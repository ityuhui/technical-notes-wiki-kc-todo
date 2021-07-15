## 加密和解密文件
使用对称密钥

### Encrypt:
```shell
openssl aes-256-cbc -a -salt -in secrets.txt -out secrets.txt.enc
```
### Decrypt:
```shell
openssl aes-256-cbc -d -a -in secrets.txt.enc -out secrets.txt.new
```

## 编程
```c
while ((err = ERR_get_error()) != 0) { 
      ERR_error_string_n(err, buf, sizeof(buf)); 
      printf("*** %s\n", buf); 
   }
```

## 验证
```shell
openssl s_client -debug -connect localhost:7871 -CAfile /root/myca/cacert.pem -CAfile /root/myca/cacert.pem -cert /root/myca/user.pem -key /root/myca/user.key

openssl s_client -msg -verify -tls1_2  -state -showcerts -cert /root/c-preview/examples/list_pod/sslconfig/client.cert -key /root/c-preview/examples/list_pod/sslconfig/client.pem -connect 9.111.254.254:6443/
```


