## env:
ubuntu server 16.04.6 vm

## step:

1. The user musb be "root"

2. Configure http and https proxy for git/shell (by polipo ) 
[Reference](https://github.com/ityuhui/rw/blob/master/shadowsocks/git_go_%E7%BB%88%E7%AB%AF_%E4%BD%BF%E7%94%A8shadowsocks%E4%BB%A3%E7%90%86.md)

3.
```
git clone git@github.com:envoyproxy/envoy.git
```

4. 
```
IMAGE_NAME=envoyproxy/envoy-build-ubuntu http_proxy=http://192.168.22.123:7777 https_proxy=http://192.168.22.123:7777 ./ci/run_envoy_docker.sh './ci/do_ci.sh bazel.dev' 
```
注意：代理不能使用127.0.0.1
