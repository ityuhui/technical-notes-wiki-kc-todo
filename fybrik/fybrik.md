# Fybrik

## 安装环境

1. 准备机器/虚拟机

2. 安装docker
```
https://docs.docker.com/engine/install/ubuntu/
```

3. 安装kubectl
```
https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
```

3. 安装helm
```
https://helm.sh/docs/intro/install/
```

4. 安装kind
```
https://kind.sigs.k8s.io/docs/user/quick-start/#installation
```

5. 使用kind创建k8s cluster
```shell
kind create cluster
```

- 本机端口跳转
```
ssh -L 8080:localhost:8080 root@kind-machine
```

## 架构

- 用户将使用数据的要求（用什么数据，对数据做什么预处理），发送给fybrik
- fybrik控制器从 catalog 处获得元数据，从 opa 处获得 policy，制作成 blueprint，（以上称作控制面），发送给数据面
- 数据面里的 blueprint handler，调用不同的module（其实就是完成某个功能的插件）对数据（分布于不同的位置）进行读取和处理，返回给用户使用。

## 目前支持的源 datastore

- db2
- s3
- kafka

## 目前支持的源 文件格式

- csv
- parquet

## 目前支持的目标 格式

- arrow

## 支持的 capability

- read
- write
- copy

## 支持的 action

- redact
- deny
- ...
- 
