要使用合适的Kubernetes 版本安装

```bash
kind create cluster  --image kindest/node:v1.21.1
```

[安装步骤](https://github.com/kubeflow/manifests#installation)

```bash
while ! kustomize build example | kubectl apply -f -; do echo "Retrying to apply resources"; sleep 10; done
```

