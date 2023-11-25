# Rust 个人总结

## 介绍

Rust是用于替代C++的语言。

## 安装

在Windows下，安装rustup-init.exe，这个软件会自动下载安装rustc（编译器），cargo（包管理和build工具）。可以使用VSCode+插件做IDE。

## 特性

### ownership

这是rust最核心的技术，是它不需要GC的原因。由编译器在编译的时候就检查一个堆上变量的作用域，当离开作用域后，就会自动调用释放内存的函数，
是C++ RAII惯用法的体现，编译器保证内存不会发生泄露和多次释放。

### 引用 reference

1. 在任何的时刻，一个变量只能有一个可变的引用，或者多个不可变的引用
1. 引用指向的值必须总是有效的

### mod

mod 用于给编译器找代码

1. `mod {}`
1. `src/modname.rs`
1. `src/modname/mod.rs`

### use

use 用于短名字
