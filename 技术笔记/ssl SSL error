```c
while ((err = ERR_get_error()) != 0) { 
      ERR_error_string_n(err, buf, sizeof(buf)); 
      printf("*** %s\n", buf); 
   }
```

```shell
openssl s_client -debug -connect localhost:7871 -CAfile /root/myca/cacert.pem -CAfile /root/myca/cacert.pem -cert /root/myca/user.pem -key /root/myca/user.key
```

