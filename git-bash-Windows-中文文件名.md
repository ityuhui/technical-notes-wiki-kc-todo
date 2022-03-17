# 让 Windows 平台上的 git bash 识别中文名

Step:

1. 创建文件
    ```bash
    touch ~/.bashrc
    ```

1. 文件内容如下：

    ```bash
    export LANG="zh_CN.UTF-8"
    export LC_ALL="zh_CN.UTF-8"
    ```