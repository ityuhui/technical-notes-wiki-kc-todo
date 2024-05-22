# 算法

## 递归函数及其优化

递归函数在返回时，如果返回的是表达式，如

```python
def f(n):
  if n == 1:
    return 1
  else:
    return n * f(n-1)
```

当 n 很大时，会造成栈溢出。

### 1. 尾递归优化

将返回改成只调用本身，如：

```python
def f(n, pre):
  if n == 1:
    return pre
  else
    return f(n-1, n * pre)
```

### 2. 缓存优化

使用一个变量或者数组，来保存已经计算过的值，以后直接使用，如：

```python
def f(n):
  result = 1
  for i in range(1, n+1):
    result = result * i
  return result
```
