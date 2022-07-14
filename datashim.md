# Datashim

## 介绍

Datashim 是一个云原生软件

提供了一个CRD：Dataset 描述数据源，目前支持 S3 和 NFS

对于每一个数据源，创建出一个 Kubernetes 集群里的 PVC ，用户可以直接使用这个 PVC 从而访问云存储。