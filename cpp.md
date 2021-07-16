* 不要返回局部对象的引用
```cpp
std::string & func()
{
    std::string temp = "hello";
    return temp; // Wrong！
}
```
引用其实是指针的语法糖