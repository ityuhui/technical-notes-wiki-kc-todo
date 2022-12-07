### 1. provision ubuntu server 18.04.2
- disk size must be greater than 30 GB

### 2. install bazel

### 3. install pre-requirement lib by apt-get

### 4. build
```
bazel build //source/exe:envoy-static
```

#### 5. run
```
./envoy-static --config-path /root/envoyconfig/envoy.yaml
```

#### 6. test

##### admin port
http://192.168.22.124:9901/

##### brower visit
http://192.168.22.124:10000 will goto baidu.com

#### my envoy.yaml
[envoy.yaml](envoy.yaml)
