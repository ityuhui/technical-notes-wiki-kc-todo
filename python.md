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

## Run Python Jupyter notebook in VSCode on remote host

Steps

1. Install "Remote Development" plugin for VSC
1. Install "Python" plugin for VSC
1. Install jupyter kernel on the remote host
    ```shell
    pip3 install ipykernel
    ```
1. Open the remote directory with VSC,
   Create New Jupyter Notebook command from the Command Palette (Ctrl+Shift+P) or by creating a new .ipynb file in your workspace.