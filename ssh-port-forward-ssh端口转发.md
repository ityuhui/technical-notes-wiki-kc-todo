将 执行命令的机器做本地端口，192.168.122.92做中转，127.0.0.1做远程
```shell
ssh -CfNg -L 6322:localhost:22 user@192.168.122.92
ssh -CfNg -L 5000:127.0.0.1:5000 user@192.168.122.92
ssh -CfNg -L 18080:127.0.0.1:18080 root@192.168.122.150
```

还可以用putty里面的tunne，来将Windows做本地端口，9.111.244.xx做中转，192.168.122.xx做远程，这样可以突破-g不生效的问题

其实转发的全景是 四台机器
- A 外部访问
- B 本地端口
- C 中转
- D 远程机

可以根据需要，将C和D合一，
