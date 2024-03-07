# tech-wiki-knowledge-center

## 云原生

- [cncf/landscape](https://github.com/cncf/landscape)

- [cncf sandbox projects](https://www.cncf.io/sandbox-projects/)

- [cncf/Backstage](https://backstage.io/)
一个创建开发者站点的工具，可以创建 software catalog，mkdoc 等

- [cncf/Contour] 使用 envoy 构建的 Kubernetes ingress controller

- [cncf/keda] Kubernetes event-based autoscaling，一个operator，接管了HPA，可以自定义 metrics 来源，例如从activemq收到消息，自动控制 deployment，解决 POD 从0到1和从1到0的问题，将从1到多和从多到1的处理交给 HPA 来做。

- [cncf/Cortex/Thanos] Prometheus setup

- [cncf/kudo] 一个创建 Kubernetes operator 的工具，使用声明式语言编写，不写代码，非常类似于 operator framework 里的 ansible，helm 方案。

- [cncf/notary] registry/image security compliance

- [如何扩展Kubernetes](https://kubernetes.io/docs/concepts/extend-kubernetes/)

- [virtual-kubelet](https://github.com/virtual-kubelet/virtual-kubelet)

- [Kubunertes HA](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/)

- [A Kubernetes Resource Interface for the Edge](https://github.com/deislabs/akri)

- [Kubernetes Device Plugins](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/)

- [Open Service Broker API](https://github.com/openservicebrokerapi/servicebroker/blob/v2.13/spec.md)

- [开放服务代理](https://www.openservicebrokerapi.org/)

- 开放服务代理和Operator是两种开发云原生程序的模式
[区别是](https://thenewstack.io/kubernetes-operators-and-the-open-service-broker-api-a-perfect-marriage/)

- [prometheus](https://github.com/prometheus/prometheus)

- [使用 prometheus 监控 kubernetes 指导](https://ityuhui.github.io/2021/05/07/notes-for-kubernetes-monitoring-prometheus/)

- [prometheus 简单实验](./prometheus-simple-experiment.md)

- grafana

- [istio](https://istio.io/latest/docs/setup/getting-started/)

- test-infra
  - <https://prow.k8s.io/>
  - <https://testgrid.k8s.io/>

- [jaegertracing/jaeger](https://github.com/jaegertracing/jaeger)

- [helm](https://helm.sh/zh/docs/intro/quickstart/) 

- git - jenkins pipeline | argo - harbor - k8s

- [Spark on k8s](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/blob/master/docs/user-guide.md)

## 以太网和虚拟网络

- [Linux 中的虚拟网络-简介](https://zboya.github.io/post/virtual_network_in_linux/)

- [Ethernet and IP Networking 101](https://iximiuz.com/en/posts/computer-networking-101/?utm_medium=reddit&utm_source=r_programming)

- [Docker四种网络模式](https://www.jianshu.com/p/22a7032bb7bd)

- linux虚拟网络：
  - bridge
  - veth

- vlan：将局域网分成多个逻辑子局域网，限制广播域

- vxlan：使用underlay来打隧道(overlay)

- overlay 和 underlay

- hostNetwork: true

## Linux

- ebpf

### 检查磁盘

```bash
sudo smartctl -a /dev/sda | less

sudo badblocks -v /dev/sda -s
```

## 后端编程和平台

- [Golang golang 总结](https://github.com/ityuhui/go-experiment/blob/main/README.md)
- libffi
- shell单元测试框架-bats

## 前端

- electron是主流的web-based 桌面应用程序方案
- javascript模块化方案
  - commonjs 是 nodejs 内置方案: `export/require`
  - ES6 自带模块化方案: `export/import`
  - AMD 和 CMD 用于浏览器侧，需要配合一个库文件，目前已经被 ES6 内置方案取代
- reactjs
  - 企业开发使用antd pro
  - nextjs是同时可以用于前端渲染和后端渲染的 reactjs，nodejs 库
- Typescript适用于node项目，前端库。自己的前端业务代码斟酌使用
- nest.js 是 typescript 的 nodejs 框架，类似于 spring
- <https://ityuhui.github.io/categories/%E5%89%8D%E7%AB%AF%E5%BC%80%E5%8F%91-Frontend-Development/>
- CSS
  - flexible box 布局
  - Tailwindcss

## 全栈开发

### 目前（2024年3月）对我个人来说最优的方案

- 前端：next.js（使用 n 管理 node）
- 后端：java spring

### 前端备选

- angular

### 后端备选

- laravel (PHP)
- nest.js (Node)
- fastapi （Python）
- gin (Golang)

## Data

- 数据库
- 数据仓库
- 大数据
  - BigTable/HBase 不是列式数据库，而是hashmap
  - ClickHouse 是列式数据库
  - Apache Parquet 是 列式数据 的文件存储格式
  - Apache Arrow 是 列式数据 的内存格式，在不同大数据系统之间高效的交换数据
  - Apache Arrow Flight 基于 gPRC 编写的 arrow 数据传输网络框架
- [我的数据库总结](https://ityuhui.github.io/2021/06/02/my-database-summary/)
- datalog metedata
  - IBM WKC
  - LF Egeria (Donated by IBM)
  - Apache Atlas

## AI

- FPGA vs ASIC
- 深度学习模型训练可以租用云GPU

## 以太坊

- [gitcoin.co](https://gitcoin.co/explorer?network=mainnet&idx_status=open&applicants=ALL&order_by=-web3_created)
- [weekinethereumnews](https://weekinethereumnews.com/)
- [Truffle Suite](https://www.trufflesuite.com/docs/truffle/quickstart)

## 编程语言和编译器

- <craftinginterpreters.com>
- Structure and Interpretation of Computer Programs(SICP) Javascript Edition [读书笔记](https://github.com/ityuhui/technical-notes-wiki-kc-todo/blob/master/%E8%AF%BB%E4%B9%A6%E7%AC%94%E8%AE%B0-SICP.md)

## 数学

- [期望和方差](./数学-math-期望和方差.md)
- [点积 内积 叉积 笛卡尔积](./数学-math-点积叉积.md)
