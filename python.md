# Python 一些总结

## yield

用于写生成器，但是可以用来写协程（现在用async 库来写协程库更好）

```python
def f123():
    yield 1
    yield 2
    yield 3

for item in f123():
    print(item)
```

```bash
1
2
3
```