# 为 SpringBoot REST 项目生成 Swagger/OpenAPI 3.0 文档

## 介绍

Swagger/OpenAPI 用于定义后端的REST API，协调前后端的开发。

## 几种开发模式

### 手工模式
1. 使用工具 swagger editor 手工编写出 API 文档
2. 前后端根据该API文档进行开发，前后端都可以用openapi-generator进行生成
3. 当 API 发生变更，需要先手工更新API文档

### 自动生成模式
1. 编写后端 API 代码
2. 使用工具 springdoc-openapi 根据后端 API 代码生成 API 文档
3. 使用 openapi-generator 生成前端（客户端）代码
4. 当 API 发生变更，直接改写后端 API 代码，然后重新生成 API 文档和前端代码

本文介绍第二种模式，因为这种模式下，API文档可维护性高，会强制保持最新版本

## Springdoc-openapi

无论是Spring还是Swagger，官方都没有提供生成 swagger 的工具。社区有两个实现：

### springfox

较早开发，对 swagger 2.x 的支持比较好

### springdoc-openapi

只支持 swagger/openapi 3.x, 目前较热门

本文介绍 springdoc-openapi

## Springdoc-openapi 的引入和使用

### 引入

在一个 SpringBoot 项目的 pom.xml 里，增加:

```xml
   <dependency>
      <groupId>org.springdoc</groupId>
      <artifactId>springdoc-openapi-ui</artifactId>
      <version>1.6.6</version>
   </dependency>
```

### 使用

执行
```shell
mvn springboot:run
```

swagger UI
```shell
curl localhost:port/v3/swagger-ui.html
```

swagger json
```shell
curl http://localhost:port/v3/api-docs
```

swagger yaml
```shell
curl http://localhost:port/v3/api-docs.yaml
```

修改地址：
```
# swagger-ui custom path
springdoc.swagger-ui.path=/swagger-ui.html

# /api-docs endpoint custom path
springdoc.api-docs.path=/api-docs
```