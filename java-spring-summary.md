# Java Spring Summary

## 控制反转 依赖注入

其实就是程序员自己写的代码，不需要再用 new 来创建对象了，而是由对象容器，也就是 Spring 框架，根据业务代码中，一个类被其他的类（通过构造函数，或者成员注解）依赖，就自动的在Spring context里创建出这个类的对象，然后交给业务代码使用。

## Anotations

### By Annotation
@Controller
is a @Component

@ComponentScan will scan and initiate all @Component class

### By JavaConfig (XML)
@Configuration
@Bean is actually a Java configuration file

### Use

@Autowared
or
constructor

## WEB 

@RequestParam ← application/x-www-form-urlencoded,

@RequestBody ← application/json,

@RequestPart ← multipart/form-data,

## Spring Security

UserDetailService
管理用户，（数据库，LDAP，内存），

PasswordEncoder
对密码进行编码
验证password是否和现有编码相匹配

都可以用 @Configura 和 @Bean 注入

AuthenticationProvider 定义了认证逻辑，将用户管理和密码管理委托给上面两个接口
authentication()
supports()

WebSecurityConfigurerAdapter已弃用:
https://blog.csdn.net/lazy_LYF/article/details/127284459

## Spring Data JPA

### 不要自动建表

src/main/resources/application.properties

```
spring.datasource.url=jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8
spring.datasource.username=root
spring.datasource.password=
spring.datasource.driver-class-name=com.mysql.jdbc.Driver

spring.jpa.show-sql: true
spring.jpa.database-platform=org.hibernate.dialect.MySQLDialect
spring.jpa.hibernate.ddl-auto=none
```

### 数据库准备

https://github.com/ityuhui/technical-notes-wiki-kc-todo/blob/master/%E4%BD%BF%E7%94%A8docker%E6%90%AD%E5%BB%BA%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE.md#mysql

## Spring 参考书

Spring in Action 微信读书 oreilly
Spring Security in Action CSDN博客 oreilly
