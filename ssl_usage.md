```c
while ((err = ERR_get_error()) != 0) { 
      ERR_error_string_n(err, buf, sizeof(buf)); 
      printf("*** %s\n", buf); 
   }
```

```shell
openssl s_client -debug -connect localhost:7871 -CAfile /root/myca/cacert.pem -CAfile /root/myca/cacert.pem -cert /root/myca/user.pem -key /root/myca/user.key

openssl s_client -msg -verify -tls1_2  -state -showcerts -cert /root/c-preview/examples/list_pod/sslconfig/client.cert -key /root/c-preview/examples/list_pod/sslconfig/client.pem -connect 9.111.254.254:6443/
```


