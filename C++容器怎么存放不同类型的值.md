# C++ 容器怎么存放不同类型的值

最简单粗暴的方法是

```c
<void*>
```

稍微工程一点的方法是
```c
struct MyType{
    enum class TypeName;
    union data;
};
```

再OO一点的方法是
```c
class IObject{};
```
作为通用基类……
