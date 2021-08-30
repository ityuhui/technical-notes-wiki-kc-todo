# Chubby: The Chubby lock service for loosely-coupled distributed systems 阅读笔记



[论文原文](https://research.google.com/archive/chubby-osdi06.pdf)

Chubby是Google开发的一个分布式锁服务，使客户端可以同步它们的信息。

Chubby可以用于分布式系统中的leader选举，例如，GFS使用Chubby锁来选出一个GFS master。

Chubby基于Paxos协议，但是它并不是一个Paxos客户端库，而是一个访问中央锁服务的库。与客户端库相比，锁服务有以下一些优点：

### 系统架构

Chubby有两个主要组件，它们之间通过RPC进行通信：一个服务器，一个客户端应用程序需要链接的库。

一个Chubby单元由被称为副本的服务器(通常是5个)集合组成，这些副本使用分布式一致性协议来选择一个master。

每个副本维护一个简单数据库的一个拷贝，但是只有master会读写该数据库，所有其他的副本只是简单地复制master通过一致性协议传送的更新。

Chubby提供了一个类似于UNIX但是相对简单的文件系统接口。

```
/ls/foo/wombat/pouch
```

一个相同的前缀ls(lockservice)
第二个名字单元(foo)代表了Chubby单元的名称
剩下的名字单元/ wombat/pouch，将会由指定的那个Chubby单元自己进行解析。

锁的持有者可能在任意时刻去请求一个sequencer，它是一系列用于描述锁获取后的状态的不透明字节串。包含了锁的名称，占有模式(互斥或共享)以及锁的世代编号。

如果client期望某个操作可以通过锁进行保护，它就将该sequencer传送给server(比如文件服务器)。接收端server需要检查该sequencer是否仍然合法及是否具有恰当的模式；如果不满足，它就拒绝该请求。

结束。