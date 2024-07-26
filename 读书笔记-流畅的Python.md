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

### 中文版

微信读书

2024年4月13日 开始阅读

### 英文原版

OReilly

2024年7月26日 开始阅读

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

## 第七章

### 迭代器 Iterator

每一个标准库的集合类，都是可迭代的

可迭代的意思是：一个提供了迭代器的对象，其迭代器可以用于 `for in` 循环、组装新的 list 等

当python要迭代一个对象x的时候，它会调用 `iter(x)`

- `iter(x)` 首先检查对象 x 是否实现了 `__iter__` 如果有，就调用它，得到一个迭代器 iterator
- 如果 x 没有实现 `__iter__` ，但是实现了 `__getitem__` ，那就创建一个 iterator，然后使用 `__getitem__(index)` 来获取 item
- 如果失败，就抛出 `TypeError`

标准库里的序列，都实现了 `__getitem__` 和 `__iter__` ，所以它们都是可迭代的。我们自己实现的可迭代类，应该也实现这两个函数。

Python 使用 `iter()` 从 iterable 得到一个 iterator，用于获得 iterable 里的 item。

Python 的实现里，iterable 是抽象基类，定义了 `__iter__` ，iterator 是其派生类，定义了 `__next__` 和 `__iter__`

![img](./pictures/flpy_1701.png)

iterator 有两个函数：

- `__next__`  返回 iterator 关联的 iterable 的下一个 item
- `__iter__`  返回 iterator 自己，用于对 iterable 访问的时候，例如 for in iterable

不要直接调用 `__next__()`，而应该使用 `next()`，后者会自动的调用前者。

#### 经典的迭代器设计模式

```python
class Sentence:

    def __init__(self, text):
        self.text = text
        self.words = RE_WORD.findall(text)

    def __repr__(self):
        return f'Sentence({reprlib.repr(self.text)})'

    def __iter__(self):
        return SentenceIterator(self.words)


class SentenceIterator:

    def __init__(self, words):
        self.words = words
        self.index = 0

    def __next__(self):
        try:
            word = self.words[self.index]
        except IndexError:
            raise StopIteration()
        self.index += 1
        return word

    def __iter__(self):
        return self
```

#### 一个生成器函数

```python
class Sentence:

    def __init__(self, text):
        self.text = text
        self.words = RE_WORD.findall(text)

    def __repr__(self):
        return 'Sentence(%s)' % reprlib.repr(self.text)

    def __iter__(self):
        for word in self.words:
            yield word
```

生成器函数是有 yield 语句的函数，它返回一个生成器对象

```python
def gen_123():
...     yield 1  1
...     yield 2
...     yield 3
...
>>> gen_123  # doctest: +ELLIPSIS
<function gen_123 at 0x...>  2
>>> gen_123()   # doctest: +ELLIPSIS
<generator object gen_123 at 0x...>  3
>>> for i in gen_123():  4
...     print(i)
1
2
3
>>> g = gen_123()  5
>>> next(g)  6
1
>>> next(g)
2
>>> next(g)
3
>>> next(g)  7
```

1
The body of a generator function often has yield inside a loop, but not necessarily; here I just repeat yield three times.

2
Looking closely, we see gen_123 is a function object.

3
But when invoked, gen_123() returns a generator object.

4
Generator objects implement the Iterator interface, so they are also iterable.

5
We assign this new generator object to g, so we can experiment with it.

6
Because g is an iterator, calling next(g) fetches the next item produced by yield.

7
When the generator function returns, the generator object raises StopIteration.

A generator function builds a generator object that wraps the body of the function. When we invoke next() on the generator object, execution advances to the next yield in the function body, and the next() call evaluates to the value yielded when the function body is suspended. Finally, the enclosing generator object created by Python raises StopIteration when the function body returns, in accordance with the Iterator protocol.
