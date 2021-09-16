# MapReduce: Simplified Data Processing on Large Clusters 阅读笔记

[论文原文](https://pdos.csail.mit.edu/6.824/papers/mapreduce.pdf)

## 编程模型

所有的操作被抽象成 Map和 Reduce 操作

计算的输入是多个<key,value>组成的集合，

Map函数由用户编写，将一个<key, value>转换成另一个<key,value>

Mapreduce库把具有相同key的那些中间值组织起来，传给Reduce函数。

Reduce函数也是用户编写的，接受一个中间值key, 以及对应于该key的value的集合作为输入。它将这些value归并起来形成一个可能更小的value集合。通常每个Reduce调用产生0个或者1个输出值。中间值的value集合是通过一个迭代器来提供给用户的Reduce函数。这允许我们能处理那些太大以至于无法一次放入内存的value列表。

## 一个简单的例子

考虑在一个大文档集合中计算单词出现频率的问题。用户可以用类似如下伪代码的方式来编写代码。

```c++
map(String key, String value):
      // key: document name
      // value: document contents
      for each word w in value:
      EmitIntermediate(w, "1"); 

reduce(String key, Iterator values):
      // key: a word
      // values: a list of counts
      int result = 0;
      for each v in values:
      result += ParseInt(v);
      Emit(AsString(result));
```

## 架构

- master负责调度，worker负责执行Map或者Reduce操作
- 数据是保存在GFS上的

结束。
