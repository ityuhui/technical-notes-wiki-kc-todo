# nodejs npm 使用

升级 nodejs

```bash
sudo npm i n -g
sudo n stable 
``````

升级 npm

```bash
sudo npm install -g npm@latest
```

查看全局软件包安装在什么地方

```bash
npm root -g
```

@前缀表示组织里的包，不是registry全局的

```bash
npm i @namesapce/package_name
```

代码里面的

```javascript
require(@abc)

import(@abc)
```

里面的 @ 是一个别名，可以在项目配置里找到解析成什么，例如

```webpack
 @: "src"
```
