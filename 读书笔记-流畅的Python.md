# 《流畅的 Python》读书笔记

## 原著版权信息

书名：流畅的Python
作者：卢西亚诺·拉马略
译者：安道,吴珂
出版社：人民邮电出版社
出版时间：2017-05-01
ISBN：9787115454157
品牌方：人民邮电出版社有限公司

## 我的阅读记录

微信读书

2024年4月13日 开始阅读

## 第一章 Python 数据模型

实现自己的数据类型的 __双下划线__ 方法，可以被 Python 解释器自动调用。

例如

```python
class FrenchDeck:
    def __init__(self):
        self._cards = [1, 2, 3]
    def __len__(self):
        return len(self._cards)
    def __getitem__(self, position):
        return self._cards[position]

deck = FrenchDeck()
len(deck) # 自动调用 __len__
print(deck[0]) # 自动调用 __getitem__
```

不会被 Python 解释器调用的双下划线方法，自己不要去写。
因为你不知道，这个双下划线方法会不会将来被解释器或者库自己去实现。

实现自己的字符串表示，加法，绝对值，乘法，bool 值：

```python
from math import hypot
class Vector:
    def __init__(self, x=0, y=0):
        self.x = x
        self.y = y
    def __repr(self)__:
        return 'Vector (%r, %r)' % (self.x, self.y)
    def __abc__(self):
        return hypot(self.x, self.y)
    def __bool__(self):
        return bool(self.x or self.y)
    def __add__(self, other):
        x = self.x + other.x
        y = self.y + other.y
        return Vector(x, y)
    def __mul__(self, scalar):
        return Vector(self.x * scalar, self.y * scalar)
```

## 第二章 序列构成的数组

