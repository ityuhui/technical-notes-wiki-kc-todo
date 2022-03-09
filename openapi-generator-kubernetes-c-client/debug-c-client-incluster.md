# Debug Kuberentes C Client in Cluster

## Step

1. Start a pod with ubuntu:latest image

    we can use the example [create_pod](https://github.com/kubernetes-client/c/tree/master/examples/create_pod)

1. Copy bin and library into the pod:

    ```shell
    kubectl cp ./libkubernetes.so test-pod-8:/
    kubectl cp ./list_pod_incluster_bin test-pod-8:/
    ```

1. Enter the pod:

    ```shell
    kubectl exec -it test-pod-8 -- bash
    ````

1. Install dependency as description in [readme](https://github.com/kubernetes-client/c) in the pod:

    ```shell

    apt update
    apt install ...
    ...
    ```
