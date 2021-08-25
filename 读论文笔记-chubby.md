# Chubby: The Chubby lock service for loosely-coupled distributed systems 阅读笔记



[论文原文](https://research.google.com/archive/chubby-osdi06.pdf)

Chubby是Google开发的一个分布式锁服务，使客户端可以同步它们的信息。

Chubby可以用于分布式系统中的leader选举，例如，GFS使用Chubby锁来选出一个GFS master。

Chubby基于Paxos协议，但是它并不是一个Paxos客户端库，而是一个访问中央锁服务的库。与客户端库相比，锁服务有以下一些优点：

1. 现有系统可以直接使用锁服务来获得分布式一致性的功能。例如，为了选举一个master并将选举结果写入一个文件服务器，只需要在现有系统中增加两个语句及一个RPC参数即可：
