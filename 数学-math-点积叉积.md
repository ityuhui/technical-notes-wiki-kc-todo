# 点积，叉积，笛卡尔积

## 点积

点积（dot product），又叫数量积，标量积（scalar product），内积（inner product），结果是一个数值。

定义：
$\vec A \cdot \vec B = \sum_{i=1}^n a_ib_i$

或者
$\vec A \cdot \vec B = \cos\theta \cdot ||A|| \cdot  ||B||$

矩阵的点积，就是矩阵的乘法运算，结果还是一个矩阵。

## 叉积

叉积（cross product），又叫矢量积，外积，结果是一个向量。

## 笛卡尔积

笛卡尔积，又叫直积。是对集合进行运算。可用于SQL，是对左右两个表的所有记录进行组合。

```sql
SELECT * FROM A, B;
```

## 内连接

```sql
SELECT * FROM A JOIN B ON ...;
```

## 外连接

分为

- 左外连接
- 右外连接
