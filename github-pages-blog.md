# GitHub Pages 备忘

## 设置或取消 github pages 定制域名

- blogsrc 源代码文件：

  https://github.com/ityuhui/blogsrc/blob/master/_config.yml


- ityuhui.github.io 在 github 上的配置页面：

  https://github.com/ityuhui/ityuhui.github.io/settings/pages

## 支持本地搜索

1. 安装插件
```bash
npm install hexo-generator-searchdb
```

2. 更新配置文件，新增：
```yaml
search:
  path: search.xml
  field: post
  content: true
  format: html
```

3. 更新主题的配置文件，修改：
```yaml
local_search:
  enable: true
```
