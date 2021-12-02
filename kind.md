# KinD

## 创建集群
```
kind create cluster
```

## 获取集群名称
```
# kind get clusters
kind
kind-2
```

## 切换集群
```
# kubectl cluster-info --context kind-kind
# kubectl cluster-info --context kind-kind-2
```

## 删除集群
```
kind delete cluster --name kind-2
```
