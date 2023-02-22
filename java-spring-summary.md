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

