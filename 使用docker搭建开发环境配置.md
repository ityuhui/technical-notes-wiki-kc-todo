# 使用 docker 搭建开发环境的配置

## mysql

```bash
yuhui@yuhui-H55M-UD2H:~$ cat start-mysql-docker-container.sh
docker run --name yuhui-mysql-docker-container -v /var/lib/mysql8:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} -p 3306:3306 -d mysql
```

## phpmyadmin

```bash
yuhui@yuhui-H55M-UD2H:~$ cat start-phpmyadmin-docker-container.sh
docker run --name yuhui-phpmyadmin-docker-container -e PMA_ARBITRARY=1 -p 8888:80 -d phpmyadmin
```

打开浏览器，访问 http://ip:8888

用户名：root 密码：启动 mysql 的命令指定

## mongodb

```bash
docker run -d \
    -p 27017:27017 \
    --name test-mongo \
    -v data-vol:/data/db \
    mongo:latest

docker exec -it <CONTAINER_NAME> bash

mongosh
```

