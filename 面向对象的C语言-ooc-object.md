# 面向对象的C

## C++使用的方法，虚函数表

https://github.com/ityuhui/ooc/blob/main/main.c

## container_of

根据 成员的首地址 得到 结构体变量的地址。

应用场景：
结构体（Child）通过包含结构体（Parent）的方式实现继承，当获得了结构体（Parent）的指针时，通过此函数可以得到结构体（Child）

## 泛型

```c
struct _GValue
{
  GType     g_type;
  union {
    gint        v_int;
    guint       v_uint;
    glong       v_long;
    gulong      v_ulong;
    gint64      v_int64;
    guint64     v_uint64;
    gfloat      v_float;
    gdouble     v_double;
    gpointer    v_pointer;
  } data[2];
};
```