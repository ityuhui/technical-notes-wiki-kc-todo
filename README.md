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

### Terraform

基础建设即服务，使用代码创建虚拟机，配置虚拟网络，安装操作系统，安装软件等

社区fork后：OpenTofu

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

## 测试框架

- Python Behave
- [Robot Framework](./robot-framework-summary.md) - Python
- 单元测试框架-bats - Shell

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

### 前端备选

- nextjs
- angular

### 后端备选

- Web项目：nextjs （JavaScript）
- 纯API：Fastify，nestjs （JavaScript, Nodejs）
- spring （Java）
- laravel (PHP)
- FastAPI（Python)
- gin (Golang)

### 其他

- Vercel
- Supabase

## Python

- [常用工具](https://ityuhui.github.io/2020/06/22/python-virtualenv-requirements-pytest-jupyter/)
- [使用 VSCode 远程运行 Python Jupyter Notebook](https://ityuhui.github.io/2023/10/18/python-jupyter-in-vscode-on-remote-host/)
- [我的项目](https://github.com/ityuhui/my-python-projects)
- Seaborn 在 Matplotlib 的基础上，进行了更高级的封装，使得作图更加方便快捷。
- [流畅的 Python](./读书笔记-流畅的Python.md)
- [Web 开发的重要概念辨析：CGI、WSGI、uWSGI、ASGI](https://baijiahao.baidu.com/s?id=1718367047580754624&wfr=spider&for=pc)
- python 可以使用 type hints 语法来写带类型的代码，解释器在运行时可以发现类型不匹配的错误，静态分析工具也可以使用。

### 模块，包

Python 的 module 是一个 .py 文件，可以import

python 的 package 的是一个文件夹，可以包含多个 module py 文件，包的文件夹里必须有 __init__.py 文件（可是是空文件，也可以包含一些初始化代码）

import 可以导入package，也可以导入module

golang 与此相反，module 包含 package

### matplotlib

- Pyplot

### sympy

符号计算，可以方便的画出函数图

### Python FastAPI Framework

- Uvicorn is an ASGI web server implementation for Python.
- Starlette is a lightweight ASGI framework/toolkit, which is ideal for building async web services in Python.
- Pydantic is the most widely used data validation library for Python.
- 用 Starlette 来写 python web backend, 使用 Uvicorn 来运行。

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
- [Golang golang 总结](https://github.com/ityuhui/go-experiment/blob/main/README.md)
- libffi
- 动态语言，譬如 Python、JavaScript，在 import 其他的文件或者模块的时候，都会把 import 的文件或者模块的 init 部分，里的全局部分，都先执行一遍，可能是 JIT 编译时执行的，也可能是运行时执行的，执行后，在内存里有一个数据结构，其中导出的、public的接口，供调用者使用。JavaScript的打包器，可能会根据 import 情况，将多个文件合并或切分，供浏览器使用。

## 数学

- [期望和方差](./数学-math-期望和方差.md)
- [点积 内积 叉积 笛卡尔积](./数学-math-点积叉积.md)
