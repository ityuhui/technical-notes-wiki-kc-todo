# 重新编译 fybrik/manager

1. 修改代码

2. 用文件编辑器查看 setup-multi-cluster.sh
 
3. 导入环境变量
 
4. 在fybrik 目录下执行

    ```shell
    make docker-build
    make docker-push
    ```

5. 删除 manager pod， 等待pod 重启
 
7. 删除旧的 5000:manager image
