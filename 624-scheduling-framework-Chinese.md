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

当没有节点可以运行这个pod时，这些插件将在 Filter 阶段之后被调用。插件按照它们配置的顺序依次执行。当任一 PostFilter 插件标记该节点为“可以调度”，剩余的插件就不会再被调用。一个典型的 PostFilter 实现是抢占。它试图通过抢占其它的pod来使得某个pod可以被调度。

#### PreScore

这是用于执行预评分工作的信息扩展点。过滤阶段得到的节点列表会被传递给插件。插件可以使用此数据来更新内部状态或生成日志/指标。

#### Scoring

这些插件有两个阶段：

1. 第一阶段是"score"，用于将传入的节点排名。调度器将调用每一个打分插件为为每一个节点打分。

2. 第二个阶段是"normalize scoring"（标准化评分），在调度器计算节点的最后排名之前修改分数。在标准化评分阶段，每一个打分插件都收到了同一个插件给出的所有的节点的分数。在每个调度周期的score阶段之后，每个插件都会执行标准化分数的操作。标准化分数是可选的，可以通过实现 ScoreExtensions 接口来提供。

分数插件的输出必须是 [MinNodeScore, MaxNodeScore] 范围内的整数。如果不是，则调度周期中止。这是运行插件的可选 NormalizeScore 函数后的输出。如果未提供 NormalizeScore，则 Score 的输出也必须在此范围内。在可选的 NormalizeScore 之后，调度器将根据配置的插件权重，将来自所有不同插件的节点分数进行组合。

举例来说，假设一个插件 `BlinkingLightScorer` 根据节点有多少闪烁的灯来对这些节点进行排序。

```go
func (*BlinkingLightScorer) Score(state *CycleState, _ *v1.Pod, nodeName string) (int, *Status) {
   return getBlinkingLightCount(nodeName)
}
```

但是，闪烁的灯的最大数量可能比 `MaxNodeScore` 要小，为了修复这个问题，`BlinkingLightScorer` 插件需要实现 `NormalizeScore`

```go
func (*BlinkingLightScorer) NormalizeScore(state *CycleState, _ *v1.Pod, nodeScores NodeScoreList) *Status {
   highest := 0
   for _, nodeScore := range nodeScores {
      highest = max(highest, nodeScore.Score)
   }
   for i, nodeScore := range nodeScores {
      nodeScores[i].Score = nodeScore.Score*MaxNodeScore/highest
   }
   return nil
}
```

If either Score or NormalizeScore returns an error, the scheduling cycle is aborted.

如果 `Score` 或 `NormalizeScore` 返回错误，调度周期就会中止。

#### Reserve

实现 Reserve 扩展的插件有两种方法，即 Reserve 和 Unreserve，分别支持称为 Reserve 和 Unreserve 的两个信息调度阶段。维护运行时状态的插件（又名“有状态插件”）应该使用这些阶段，以便在节点上的资源为给定 Pod 保留和取消保留时由调度程序通知。

Reserve 阶段发生在调度程序实际将 Pod 绑定到其指定节点之前。它的存在是为了在调度程序等待绑定成功时防止race conditions。每个 Reserve 插件的 Reserve 方法可能成功也可能失败；如果一个 Reserve 方法调用失败，则不会执行后续插件，并且 Reserve 阶段被视为失败。如果所有插件的 Reserve 方法都成功，则认为 Reserve 阶段成功，执行剩余的调度周期和绑定周期。

如果 Reserve 阶段或后续阶段失败，则触发 Unreserve 阶段。发生这种情况时，所有 Reserve 插件的 Unreserve 方法将按照 Reserve 方法调用的相反顺序执行。此阶段的存在是为了清理与保留的 Pod 关联的状态。

*注意： Reserve 插件中 Unreserve 方法的实现必须是幂等的，不能失败。*

#### Permit

这些插件用于阻止或延迟一个pod的绑定。一个 permet 插件可以做以下三件事情之一：

1. approve
一旦所有的 permit 插件批准了一个 pod，pod被发出用于绑定。

2. deny
如果任意一个 permit 插件拒绝了一个 pod, 该pod被退回到调度队列。这将激活 Reserve 插件的 Unreserve 方法。

3. wait (带有一个timeout)
如果一个 permit 插件返回“wait”，该pod 保持在 permit阶段，直到一个插件批准它。如果timeout到达，wait变为deny，该pod
If a permit plugin returns "wait", then the pod is kept in the permit phase until a plugin approves it. If a timeout occurs, wait becomes deny and the pod is returned to the scheduling queue, triggering unreserve method in Reserve phase. 该pod被退回到调度队列，并激活 Reserve 插件的 Unreserve 方法。

Permit 插件作为调度周期的最后一步被执行，permi阶段的 waiting 发生在绑定周期的开始，PreBind插件执行之前。

#### Approving a pod binding

虽然任何插件都可以从缓存中接收保留列表里的 Pod 并批准它们（参见 FrameworkHandle），但我们希望只有 permit 插件批准处于“waiting”状态的保留 Pod 的绑定。一旦 Pod 被批准，它就会被发送到 pre-bind 阶段。

#### PreBind

这些插件用于在绑定 pod 之前执行所需的任何工作。例如，prebind 插件可能会提供一个网络卷并将其安装在目标节点上，然后再允许 pod 在那里运行。

如果任何 PreBind 插件返回错误，则 Pod 将被拒绝并返回到调度队列。

#### Bind

这些插件用于将 pod 绑定到节点。在所有 PreBind 插件完成之前，不会调用 Bind 插件。每个 bind 插件都按配置的顺序调用。Bind 插件可以选择是否处理给定的 Pod。如果 bind 插件选择处理 Pod，其余的 bind 插件则会被跳过。

#### PostBind

这是一个信息扩展点。 PostBind 插件在 pod 成功绑定后被调用。这是绑定周期的结束，可用于清理相关资源。

### Plugin API

plugin API 有两个步骤。首先，插件必须注册和配置，其次，插件被絮使用扩展点接口。扩展点接口的形式如下：

```golang
type Plugin interface {
   Name() string
}

type QueueSortPlugin interface {
   Plugin
   Less(*PodInfo, *PodInfo) bool
}


type PreFilterPlugin interface {
   Plugin
   PreFilter(CycleState, *v1.Pod) *Status
}

// ...
```

#### CycleState

大多数插件函数*调用时都会带有参数 `CycleState`，一个 `CycleState` 代表了当前的调度上下文

一个 `CycleState` 将提供用于访问当前调度上下文范围内的数据的 API。由于绑定周期可能会并发的执行，插件可以使用 `CycleState` 来确保它们正在处理正确的请求。

**唯一的例外是 [queue sort](https://github.com/kubernetes/enhancements/tree/master/keps/sig-scheduling/624-scheduling-framework#queue-sort) 插件。*

警告: 通过 `CycleState` 得到的数据在一次调度上下文结束之后就会失效。在超过必要的时间后，插件不应当持有指向数据的引用。

#### FrameworkHandle


