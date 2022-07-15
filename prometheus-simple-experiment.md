# Prometheus 简单实验

## Step

### 安装 cluster

```bash
kind create cluster
```

### 安装 Prometheus

```bash
user@machine:~$ helm install prometheus-helm-install-yuhui-0715 prometheus-community/prometheus
NAME: prometheus-helm-install-yuhui-0715
LAST DEPLOYED:
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The Prometheus server can be accessed via port 80 on the following DNS name from within your cluster:
prometheus-helm-install-yuhui-0715-server.default.svc.cluster.local


Get the Prometheus server URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9090


The Prometheus alertmanager can be accessed via port 80 on the following DNS name from within your cluster:
prometheus-helm-install-yuhui-0715-alertmanager.default.svc.cluster.local


Get the Alertmanager URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=alertmanager" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9093


The Prometheus PushGateway can be accessed via port 9091 on the following DNS name from within your cluster:
prometheus-helm-install-yuhui-0715-pushgateway.default.svc.cluster.local


Get the PushGateway URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=pushgateway" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace default port-forward $POD_NAME 9091

For more information on running Prometheus, visit:
https://prometheus.io/
```

### 转发端口

```bash
export POD_NAME=$(kubectl get pods --namespace default -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")

kubectl --namespace default port-forward $POD_NAME 9090
```

### 本地端口转发

如果要在本地访问
```bash
ssh -L 9090:localhost:9090 root@machine 
```

### 访问 GUI

使用浏览器访问

```bash
localhost:9090
```

### simple_profiler

```bash
./run_profiler.sh -m bin -p 4 -c kubernetes
```
