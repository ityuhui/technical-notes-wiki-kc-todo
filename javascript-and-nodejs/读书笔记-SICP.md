# Structure and Interpretation of Computer Programs(SICP) Javascript Edition

闭包：

```javascript
function pair(x, y) {
    return m => m(x, y);
}

function head(z) {
    return z((p, q) => p);
}

function tail(z) {
    return z((p, q) => q);
}

const pai = pair(1,2);
console.log(head(pai));
console.log(tail(pai));
```
