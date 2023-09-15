# 下载 Oreilly 电子书

## 步骤

1. 配置 Python 虚拟环境
2. git clone 仓库
3. 登录 oreilly profile，使用 Firefox 开发者工具：

```
Network -> "/profile" -> Cookies -> Request Cookies
```

右键，拷贝所有，保存成 cookies.json，将最外层的 key 去掉。

4. 执行(最好在科学环境下)

```bash
python3 safaribooks.py XXXXX
```
