# 容器网络接口（CNI）规范

## 网络配置格式

```yaml
{
  "cniVersion": "1.0.0",
  "name": "dbnet",
  "plugins": [
    {
      "type": "bridge",
      // plugin specific parameters
      "bridge": "cni0",
      "keyA": ["some more", "plugin specific", "configuration"],
      
      "ipam": {
        "type": "host-local",
        // ipam specific
        "subnet": "10.1.0.0/16",
        "gateway": "10.1.0.1",
        "routes": [
            {"dst": "0.0.0.0/0"}
        ]
      },
      "dns": {
        "nameservers": [ "10.1.0.1" ]
      }
    },
    {
      "type": "tuning",
      "capabilities": {
        "mac": true
      },
      "sysctl": {
        "net.core.somaxconn": "500"
      }
    },
    {
        "type": "portmap",
        "capabilities": {"portMappings": true}
    }
  ]
}
```

## 执行协议

### 参数

- CNI_COMMAND
- CNI_CONTAINERID
- CNI_NETNS
- CNI_IFNAME
- CNI_ARGS
- CNI_PATH

### 操作

- ADD
- DEL
- CHECK
- VERSION

## 网络配置执行

- Adding an attachment
- Deleting an attachment
- Checking an attachment
- Deriving execution configuration from plugin configuration

## 插件代理

`ipam`

## 结果类型

## 总结

当容器要创建或者删除网络接口的时候，容器运行时调用容器网络接口运行时，CNI将配置从Stdin喂入，调用插件，然后将结果以json格式输出，容器运行时拿到整个输出，设置容器的网络。