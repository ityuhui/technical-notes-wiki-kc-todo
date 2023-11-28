# JavaScript 异步

JavaScript 有三种异步：

## callback

回调函数，当条件达到是触发，容易引起 “callback hell” 问题

## promise

一个对象，里面带 resolve 和 reject 两个回调函数，使用 then 来触发，可以实现多个回调函数的顺序执行

.then().catch()

## await/async

语法糖，更舒服的使用 promise

await

## 改造 callback

可以写一个回调函数，里面创建一个promise，并返回，这个函数就可以用于 await 了。
