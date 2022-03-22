# Authentication

## Abstract

- jwt
- oidc
- openid connect
- oauth2

## JWT

JWT 是 lll.xxx.yyy 格式的字符串，分三部分，每部分都是base64编码后的串
- lll: 头信息，里面会指明签名算法
- xxx: payload
- yyy: 签名，可以用于证明JWT未被篡改

JWS：加签名（有yyy部分）的 JWT

可以由服务端自己生成，返回给客户端，收到客户端发来的 JWT后，自己验证：
- 校验签名
- Token 是否过期 

JWT 内容是明文的，可能会被劫持，所以要用https传输，并且设置比较短的有效期
如果用户改了密码，应该马上在服务器端使其所有的 JWT 失效，否则攻击者可以使用 refresh token 不同的更新 JWT

## OIDC

OpenID Connect

就是 Identity（Authentication) + OAuth2.0

使用 JWT 作为 Token

OpenID 服务器签发三个 JWT 给应用程序的服务端：
- ID Token：（识别身份，鉴权）
- Access Token：用于访问受保护的资源（授权）
- Refresh Token

常见的 OpenID Connect 服务器有：
- 各个云平台提供的身份服务器
- Keycloak

## OAuth2

仅用于 授权 ，发布两个token
- Access Token

## JWT 缺点 和 可选方案

JWT 一旦被盗，服务器无法应对，只能等待 JWT 到期。所以需要在服务器端维护一个 JWT 列表，这样在 多服务器 环境下无法工作，所以又需要引入 redis 来集群储存 JWT，这样又回到了 session- redis 模式

可选方案：
- 自己创建一个 token, key是一个哈希值，value是 用户信息，保存到 redis 里。这其实还是 session- redis模式
- 使用消息队列来通知 JWT 
JWT 一旦被盗，服务器无法应对，只能等待 JWT 到期。所以需要在服务器端维护一个 JWT 列表，这样在 多服务器 环境下无法工作，所以又需要引入 redis 来集群储存 JWT，这样又回到了 session- redis 模式f昂发
JWT 一旦被盗，服务器无法应对，只能等待 JWT 到期。所以需要在服务器端维护一个 JWT 列表，这样在 多服务器 环境下无法工作，所以又需要引入 redis 来集群储存 JWT，这样又回到了 session- redis 模式

