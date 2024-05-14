# WSL2 使用

## 常用命令

```bash
$ wsl -l -v
  NAME                   STATE           VERSION
* Ubuntu                 Running         2
  docker-desktop-data    Running         2
  docker-desktop         Running         2
```

## 与 docker desktop 集成

安装 docker desktop 之后，在 Windows PowerShell 里就可以访问 docker 了。也可以直接启动docker container

如果在 WSL2 里的 ubuntu 里遇到下面的问题：

```bash
docker ps
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

需要在 Docker Desktop 的设置 -> Resource -> WSL integration -> Enable integration with my default WSL distro

## 遇到的问题

### 1. VSCode Remote 无法连接 WSL2 容器

问题描述：连接 WSL2 时无法下载证书

解决：使用 VSCode Remote SSH 连接到WSL里，退出，再使用 WSL2 模式连接，就成功了。

### 1. sudo 或者 sudo -E 无法带入环境变量

```bash
sudo -i ${command} # 登录，所以会读入 /etc/profile.d/
sudo -s # 等价于 sudo su，不同的是 -s 使用原来的环境变量
```
