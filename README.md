# ethrpc-jwt-proxy

ethrpc-jwt-proxy is an HTTP proxy that restrict access to the RPC interface of ethereum clients like geth

It is based https://github.com/auth0/nginx-jwt with minor modifications to get the JWT from the query string

## Setup on OSX

```
git clone git@github.com:WeTrustPlatform/ethrpc-jwt-proxy.git
brew install openresty/brew/openresty
brew install lua
opm get SkyLothar/lua-resty-jwt
luarocks install basexx
```

## Configuration

```
export JWT_SECRET=fofofo
export JWT_SECRET_IS_BASE64_ENCODED=false
```

## Launch

```
cd ethrpc-jwt-proxy
openresty -c ~/ethrpc-jwt-proxy/nginx.conf -g 'daemon off;'
```

## Test

```
curl --request GET --url 'http://localhost:8088/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJyb2xlcyI6WyJzYWxlcyIsIm1hcmtldGluZyJdfQ.jTlvWuv2mhjD8wLy7XZB0x41E71WCUBi6xhAEEz_M-w' -i
```

## Attach

```
geth attach http://localhost:8088/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJyb2xlcyI6WyJzYWxlcyIsIm1hcmtldGluZyJdfQ.jTlvWuv2mhjD8wLy7XZB0x41E71WCUBi6xhAEEz_M-w
```
