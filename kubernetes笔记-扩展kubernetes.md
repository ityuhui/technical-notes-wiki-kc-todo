# 阅读《扩展Kubernetes》笔记

## 聚合层和扩展API server

聚合层运行在kubernetes API server内部，用于将用户自定义的URL转发给扩展API server。
聚合层不同于定制资源(CR)，定制资源用于提供新的Kubernetes类型(Kind)
