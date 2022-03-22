# Authentication

## JWT

JWT 是 lll.xxx.yyy 格式的字符串，分三部分，每部分都是base64编码后的串
- lll: 头信息，指明签名算法
- xxx: payload
- yyy: 签名，可以用于证明JWT未被篡改

JWS：加签名（有yyy部分）的 JWT

可以由服务端自己生成，返回给客户端，收到客户端发来的 JWT后，自己验证

## OIDC

OpenID Connect，使用 JWT 作为 Token 的 OpenID (OAuth2)

OpenID 服务器签发两个 JWT 给应用程序的服务端,
- Access Token
- Refresh Token

常见的 OpenID Connect 服务器实现有：
- Keycloak

## OAuth2

