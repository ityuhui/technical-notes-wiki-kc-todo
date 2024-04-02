# Robot Framework

## 官方文档学习笔记

### 启动脚本

可以使用 python 来写 robot 启动脚本

### 文件命名

最好在 test suite 文件的前面加上 01 这种序号

### 忽略 test case

```robot
*** Test Cases ***
Example
    [Tags]    robot:skip
    Log       This is not executed
```

### 有效的 test 文件

All files and directories starting with a dot (.) or an underscore (_) are ignored.

### 各种文件的原理

Test case files, test suite initialization files and resource files are all created using Robot Framework test data syntax. Test libraries and variable files are created using “real” programming languages, most often Python.

### 空和空格的表示

空就是 `\`, 或者 `${EMPTY}`
空格是 `\ `, 或者  `${SPACE}`

### 变量生效

When a scalar variable is used alone without any text or other variables around it, like in ${GREET} above, the variable is replaced with its value as-is and the value can be any object. If the variable is not used alone, like ${GREER}, ${NAME}!! above, its value is first converted into a string and then concatenated with the other data.

### 数字表示

`${10}`

### 使用环境变量

```robot
Run    %{JAVA_HOME}${/}javac
```

### 创建变量和赋值

Settings 里创建变量

```robot
*** Variables ***
@{NAMES}        Matti       Teppo
```

在 test 里动态创建 list

```robot
${items} =    Create List    first    second    third
```

test 和 keyword 里还有一种形式创建变量：

```robot
VAR    @{two items}     Robot    Framework
```

## 变量文件

可以使用 Variable file 来定义更加灵活和高级的变量，文件形式有 python 源代码文件，以及yaml/json

## 工具

robotidy 对代码文件进行规范化，相当于 gofmt
