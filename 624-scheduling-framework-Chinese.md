# 调度框架

原文：https://github.com/kubernetes/enhancements/tree/master/keps/sig-scheduling/624-scheduling-framework

## 总结

本文档描述了 Kubernetes 调度框架。它是向已经存在的 Kubernetes 调度器添加的一组新的插件API。插件被编译进调度器，这些API在保持核心调度器简单且便于维护的同时，将额外的调度功能实现为插件。

## 动机

Kubernetes 调度器不停的增加新特性，使得代码越来越多、逻辑越来越复杂。当前 Kubernetes 调度器提供了 webhook 来扩展，但是它有几个缺点：

1. 扩展点的数量是有限的："Filter"扩展在默认的预选函数后执行，"Prioritize"扩展在默认的优选函数后执行。"Preempt"扩展在默认的抢占机制后运行。扩展的"Bind"谓词被用于绑定到一个Pod。只有一个扩展可以成为一个绑定扩展，扩展执行绑定代替了调度器。扩展不能再其它的点上执行，例如，它们不能在预选函数之前被调用。

2. 每一个扩展器的调用都会涉及对JSON的打包和解包，因此对于webhook的调用比原生函数要慢。

3. 当调度器已经放弃对一个pod的调度，这个事件是很难通知给一个扩展的。例如，如果一个扩展管理着集群的资源，当调度器请求扩展来为一个被调度的pod创建一个资源的实例时，调度器发生了错误，决定放弃调度，调度器则很难与扩展通讯来撤销资源的分配。

4. 以为当前的扩展都运行为一个独立的进程，它们不能使用调度器的缓存。它们必须要么从API Server处构建自己的缓存，要么只处理它们从默认调度器收到的信息。

上述限制将妨碍创建高性能和多样的调度器特性。我们想要由一个足够快的扩展机制来将已有的特性转换为插件，例如预选和优选函数。这些插件将被编译到调度器内。除此之外，定制调度器的作者可以使用未修改的调度器代码和他们自己的插件来编译一个定制调度器。

## 目标

- 使调度器的扩展性更强。

- 通过将一些特性转移到插件里，从而使得调度器核心更加的简单。

- 在框架里提供扩展点。

- 提供一个接收插件执行结果，并基于该结果继续或放弃的机制。

- 提供一个错误处理和与插件通讯的机制。

## 不是目标

- 解决调度器的所有限制。虽然我们努力确保新框架在未来允许我们处理已知的限制。

- 提供插件的实现细节和回调函数，以及它们所有的参数和返回值。

## 提案

调度框架定义了新的扩展点和Kubernetes调度器内供插件使用的Go API。插件编译进调度器编译内。调度器的ComponentConfig将允许激活，禁用和重新排序插件。定制调度器可以在自身代码树之外写它们的插件，并编译进定制调度器。

### 调度周期和绑定周期

每一次对一个pod的调度都被分成两个阶段，调度周期和绑定周期。调度周期为pod选择一个节点，绑定周期将决定应用到集群上。调度周期和绑定周期一起被成文一个“调度上下文”。调度周期是串行执行的，绑定周期有可能并行执行。

如果pod被认为不可调度或者发生了内部错误，调度周期或绑定周期可以被中止。pod将回到队列里重新重试调度。如果一个绑定周期被中止，将会启动Reserve插件的Unreserve方法。

### 扩展点

下图展示了pod的调度上下文和调度框架暴露出来的扩展点。在该图里，"Filter"与"预选"等价，"Scoring"就是优选函数。插件被注册在一个或多个扩展点供调用。我们将根据调用的顺序来描述每一个扩展点。

一个插件可以注册在多个扩展点上来执行许多复杂或者有状态的任务。

![pict](https://github.com/kubernetes/enhancements/blob/master/keps/sig-scheduling/624-scheduling-framework/scheduling-framework-extensions.png)

#### Queue sort

这些插件用于给在调度队列里的pod排序。一个queue sort插件必须提供一个 `less(pod1, pod2)` 函数。同一时间里只有一个queue sort插件可以被激活。

#### PreFilter

这些插件用于预处理pod的信息，或者检查集群是否满足pod的某个特定条件。一个pre-filter插件必须实现一个 `PreFilter` 函数。如果 `PreFilter` 返回一个失败，调度周期将中止。注意 `PreFilter` 在每次调度周期只能被调用一次。

A Pre-filter plugin can implement the optional PreFilterExtensions interface which define AddPod and RemovePod methods to incrementally modify its pre-processed info. The framework guarantees that those functions will only be called after PreFilter, possibly on a cloned CycleState, and may call those functions more than once before calling Filter on a specific node.

一个 Pre-filter 插件可以选择实现 `PreFilterExtensions` 接口，该接口定义了 `AddPod` 和 `RemovePod` 方法，增量的修改它的预处理过的信息。框架保证这些函数只在 `PreFilter` 之后调用，可能在一个复制的 CycleState 上。在一个特定的节点上，在 Filter 调用之前可能多次调用这些函数。

#### Filter

这些插件用于过滤掉那些不能运行pod的节点。对于每一个节点，调度器将按照配置的顺序，调用 filter 插件。当任意一个filter插件将节点标记为不可用，剩余的插件就不会在该节点上被调用。节点的评估可能是并行的，因此 `Filter` 在一个调度周期里，可能被多次调用。

#### PostFilter

These plugins are called after Filter phase, but only when no feasible nodes were found for the pod. Plugins are called in their configured order. If any PostFilter plugin marks the node as Schedulable, the remaining plugins will not be called. A typical PostFilter implementation is preemption, which tries to make the pod schedulable by preempting other Pods.