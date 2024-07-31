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

生成器表达式是生成器函数的语法糖

列表推导式 和 生成器表达式 都是 生成器的应用，区别是：
列表推导是 eager 的，所有的 item 都被计算出来，组成列表。
生成器表达式是 lazy 的，它返回一个生成器，用到 item 的时候时候才会计算该 item

```python
>>> def vowel(c):
...     return c.lower() in 'aeiou'
...
>>> list(filter(vowel, 'Aardvark'))
['A', 'a', 'a']
>>> import itertools
>>> list(itertools.filterfalse(vowel, 'Aardvark'))
['r', 'd', 'v', 'r', 'k']
>>> list(itertools.dropwhile(vowel, 'Aardvark'))
['r', 'd', 'v', 'a', 'r', 'k']
>>> list(itertools.takewhile(vowel, 'Aardvark'))
['A', 'a']
>>> list(itertools.compress('Aardvark', (1, 0, 1, 1, 0, 1)))
['A', 'r', 'd', 'a']
>>> list(itertools.islice('Aardvark', 4))
['A', 'a', 'r', 'd']
>>> list(itertools.islice('Aardvark', 4, 7))
['v', 'a', 'r']
>>> list(itertools.islice('Aardvark', 1, 7, 2))
['a', 'd', 'a']


>>> sample = [5, 4, 2, 8, 7, 6, 3, 0, 9, 1]
>>> import itertools
>>> list(itertools.accumulate(sample))  
[5, 9, 11, 19, 26, 32, 35, 35, 44, 45]
>>> list(itertools.accumulate(sample, min))  
[5, 4, 2, 2, 2, 2, 2, 0, 0, 0]
>>> list(itertools.accumulate(sample, max))  
[5, 5, 5, 8, 8, 8, 8, 8, 9, 9]
>>> import operator
>>> list(itertools.accumulate(sample, operator.mul))  
[5, 20, 40, 320, 2240, 13440, 40320, 0, 0, 0]
>>> list(itertools.accumulate(range(1, 11), operator.mul))
[1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800]


>>> list(enumerate('albatroz', 1))
[(1, 'a'), (2, 'l'), (3, 'b'), (4, 'a'), (5, 't'), (6, 'r'), (7, 'o'), (8, 'z')]
>>> import operator
>>> list(map(operator.mul, range(11), range(11)))  
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
>>> list(map(operator.mul, range(11), [2, 4, 8]))  
[0, 4, 16]
>>> list(map(lambda a, b: (a, b), range(11), [2, 4, 8]))  
[(0, 2), (1, 4), (2, 8)]
>>> import itertools
>>> list(itertools.starmap(operator.mul, enumerate('albatroz', 1)))  
['a', 'll', 'bbb', 'aaaa', 'ttttt', 'rrrrrr', 'ooooooo', 'zzzzzzzz']
>>> sample = [5, 4, 2, 8, 7, 6, 3, 0, 9, 1]
>>> list(itertools.starmap(lambda a, b: b / a,
...     enumerate(itertools.accumulate(sample), 1)))  
[5.0, 4.5, 3.6666666666666665, 4.75, 5.2, 5.333333333333333,
5.0, 4.375, 4.888888888888889, 4.5]


>>> list(itertools.chain('ABC', range(2)))  1
['A', 'B', 'C', 0, 1]
>>> list(itertools.chain(enumerate('ABC')))  2
[(0, 'A'), (1, 'B'), (2, 'C')]
>>> list(itertools.chain.from_iterable(enumerate('ABC')))  3
[0, 'A', 1, 'B', 2, 'C']
>>> list(zip('ABC', range(5), [10, 20, 30, 40]))  4
[('A', 0, 10), ('B', 1, 20), ('C', 2, 30)]
>>> list(itertools.zip_longest('ABC', range(5)))  5
[('A', 0), ('B', 1), ('C', 2), (None, 3), (None, 4)]
>>> list(itertools.zip_longest('ABC', range(5), fillvalue='?'))  6
[('A', 0), ('B', 1), ('C', 2), ('?', 3), ('?', 4)]


>>> list(itertools.product('ABC', range(2)))  1
[('A', 0), ('A', 1), ('B', 0), ('B', 1), ('C', 0), ('C', 1)]
>>> suits = 'spades hearts diamonds clubs'.split()
>>> list(itertools.product('AK', suits))  2
[('A', 'spades'), ('A', 'hearts'), ('A', 'diamonds'), ('A', 'clubs'),
('K', 'spades'), ('K', 'hearts'), ('K', 'diamonds'), ('K', 'clubs')]
>>> list(itertools.product('ABC'))  3
[('A',), ('B',), ('C',)]
>>> list(itertools.product('ABC', repeat=2))  4
[('A', 'A'), ('A', 'B'), ('A', 'C'), ('B', 'A'), ('B', 'B'),
('B', 'C'), ('C', 'A'), ('C', 'B'), ('C', 'C')]
>>> list(itertools.product(range(2), repeat=3))
[(0, 0, 0), (0, 0, 1), (0, 1, 0), (0, 1, 1), (1, 0, 0),
(1, 0, 1), (1, 1, 0), (1, 1, 1)]
>>> rows = itertools.product('AB', range(2), repeat=2)
>>> for row in rows: print(row)
...
('A', 0, 'A', 0)
('A', 0, 'A', 1)
('A', 0, 'B', 0)
('A', 0, 'B', 1)
('A', 1, 'A', 0)
('A', 1, 'A', 1)
('A', 1, 'B', 0)
('A', 1, 'B', 1)
('B', 0, 'A', 0)
('B', 0, 'A', 1)
('B', 0, 'B', 0)
('B', 0, 'B', 1)
('B', 1, 'A', 0)
('B', 1, 'A', 1)
('B', 1, 'B', 0)
('B', 1, 'B', 1)


>>> ct = itertools.count()  1
>>> next(ct)  2
0
>>> next(ct), next(ct), next(ct)  3
(1, 2, 3)
>>> list(itertools.islice(itertools.count(1, .3), 3))  4
[1, 1.3, 1.6]
>>> cy = itertools.cycle('ABC')  5
>>> next(cy)
'A'
>>> list(itertools.islice(cy, 7))  6
['B', 'C', 'A', 'B', 'C', 'A', 'B']
>>> list(itertools.pairwise(range(7)))  7
[(0, 1), (1, 2), (2, 3), (3, 4), (4, 5), (5, 6)]
>>> rp = itertools.repeat(7)  8
>>> next(rp), next(rp)
(7, 7)
>>> list(itertools.repeat(8, 4))  9
[8, 8, 8, 8]
>>> list(map(operator.mul, range(11), itertools.repeat(5)))  10
[0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]


>>> list(itertools.combinations('ABC', 2))  1
[('A', 'B'), ('A', 'C'), ('B', 'C')]
>>> list(itertools.combinations_with_replacement('ABC', 2))  2
[('A', 'A'), ('A', 'B'), ('A', 'C'), ('B', 'B'), ('B', 'C'), ('C', 'C')]
>>> list(itertools.permutations('ABC', 2))  3
[('A', 'B'), ('A', 'C'), ('B', 'A'), ('B', 'C'), ('C', 'A'), ('C', 'B')]
>>> list(itertools.product('ABC', repeat=2))  4
[('A', 'A'), ('A', 'B'), ('A', 'C'), ('B', 'A'), ('B', 'B'), ('B', 'C'),
('C', 'A'), ('C', 'B'), ('C', 'C')]

>>> list(itertools.groupby('LLLLAAGGG'))  1
[('L', <itertools._grouper object at 0x102227cc0>),
('A', <itertools._grouper object at 0x102227b38>),
('G', <itertools._grouper object at 0x102227b70>)]
>>> for char, group in itertools.groupby('LLLLAAAGG'):  2
...     print(char, '->', list(group))
...
L -> ['L', 'L', 'L', 'L']
A -> ['A', 'A',]
G -> ['G', 'G', 'G']
>>> animals = ['duck', 'eagle', 'rat', 'giraffe', 'bear',
...            'bat', 'dolphin', 'shark', 'lion']
>>> animals.sort(key=len)  3
>>> animals
['rat', 'bat', 'duck', 'bear', 'lion', 'eagle', 'shark',
'giraffe', 'dolphin']
>>> for length, group in itertools.groupby(animals, len):  4
...     print(length, '->', list(group))
...
3 -> ['rat', 'bat']
4 -> ['duck', 'bear', 'lion']
5 -> ['eagle', 'shark']
7 -> ['giraffe', 'dolphin']

>>> for length, group in itertools.groupby(reversed(animals), len): 5
...     print(length, '->', list(group))
...
7 -> ['dolphin', 'giraffe']
5 -> ['shark', 'eagle']
4 -> ['lion', 'bear', 'duck']
3 -> ['bat', 'rat']
>>>

>>> list(itertools.tee('ABC'))
[<itertools._tee object at 0x10222abc8>, <itertools._tee object at 0x10222ac08>]
>>> g1, g2 = itertools.tee('ABC')
>>> next(g1)
'A'
>>> next(g2)
'A'
>>> next(g2)
'B'
>>> list(g1)
['B', 'C']
>>> list(g2)
['C']
>>> list(zip(*itertools.tee('ABC')))
[('A', 'A'), ('B', 'B'), ('C', 'C')]

```
