# KinD

## 创建集群

```bash
kind create cluster
```

## 获取集群名称

```bash
kind get clusters
kind
kind-2
```

## 切换集群

```bash
kubectl config use-context kind-2
```

## 删除集群

```bash
kind delete cluster --name kind-2
```

## 创建 Kubernetes service

```bash
kubectl expose deployment my-notebook --port=8888 --target-port=8888
kubectl port-forward svc/my-notebook 8888:8888 &
ssh -L 8888:localhost:8888 root@example.com
```
