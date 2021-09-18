# 调度框架

原文：https://github.com/kubernetes/enhancements/tree/master/keps/sig-scheduling/624-scheduling-framework

## 总结

本文档描述了 Kubernetes 调度框架。它是向已经存在的 Kubernetes 调度器添加的一组新的插件API。插件被编译进调度器，这些API在保持核心调度器简单且便于维护的同时，将额外的调度功能实现为插件。

## 动机

Kubernetes 调度器不停的增加新特性，使得代码越来越多、逻辑越来越复杂。当前 Kubernetes 调度器提供了 webhook 来扩展，但是它有几个缺点：

The number of extension points are limited: "Filter" extenders are called after default predicate functions. "Prioritize" extenders are called after default priority functions. "Preempt" extenders are called after running default preemption mechanism. "Bind" verb of the extenders are used to bind a Pod. Only one of the extenders can be a binding extender, and that extender performs binding instead of the scheduler. Extenders cannot be invoked at other points, for example, they cannot be called before running predicate functions.

1. 扩展点的数量是有限的："Filter"扩展在默认的预选函数后执行，"Prioritize"扩展在默认的优选函数后执行。"Preempt"扩展在默认的抢占机制后运行。扩展的"Bind"动词被用于绑定到一个Pod。
