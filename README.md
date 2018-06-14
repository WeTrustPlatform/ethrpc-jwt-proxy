# ethrpc-jwt-proxy

ethrpc-jwt-proxy is an HTTP proxy that restrict access to the RPC interface of ethereum clients like geth

It is based https://github.com/auth0/nginx-jwt with minor modifications to get the JWT from the query string

## Setup on Ubuntu

```
git clone http://github.com/WeTrustPlatform/ethrpc-jwt-proxy.git
sudo add-apt-repository ppa:openresty/ppa
sudo apt-get update
sudo apt-get install openresty luarocks
sudo luarocks install lua-resty-jwt
sudo luarocks install basexx
export LUA_PATH="$HOME/ethrpc-jwt-proxy/?.lua;/usr/local/share/lua/5.1/?.lua;;"
```

## Setup on OSX

```
git clone http://github.com/WeTrustPlatform/ethrpc-jwt-proxy.git
brew install openresty/brew/openresty
brew install lua
luarocks install lua-resty-jwt
luarocks install basexx
export LUA_PATH="$HOME/ethrpc-jwt-proxy/?.lua;/usr/local/Cellar/lua/5.3.4_4/share/lua/5.3/?.lua;;"
```

## Generate the key pair

```
ssh-keygen -t rsa -b 4096 -f jwtRS256.key
# Don't add passphrase
openssl rsa -in jwtRS256.key -pubout -outform PEM -out jwtRS256.key.pub
cat jwtRS256.key
cat jwtRS256.key.pub
```

## Configuration

Copy your public key in config.lua. For example:

```
_M.secret = [[-----BEGIN PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAtqG+O07/SIXu59FpzX2V
Kvzfs72asN3zwsxYOxN30Md9L1wfh/2bxZ67VkPl+CP717PoGUaFW0xsXTyEHCYP
go5NwvznhAn08FAwMDjy2BlL2tm8RuTMgfFdfEz3SEzGjOj/Ruvrv51LL6SDVnh+
DKx/2nnNWk+DzI144RxjBvE0LxB+rxWlvJmGHLeJoFvwP/sFykGKqqplBUipAu2K
Aypinx4ts1JwUfb03qN7MhlWmWk0RWdSiwxr4e2OGeeBx8V9w2mwv3JjFwMB7uiU
EPx69+gDkaoxZKj94Jv0dm6vSErWxYsfv6OZTRhlZO2eCSV+7Ydg+iueq7SaTlpj
gPSGMMjaXgewCiUO+RS7r8AAWWAqG1ceovFCk6wMYqbYc7tFlsspy+vloWp86sBx
ncD042W7ZPWLccpK2xeIXMdugViCytS8fn0zsLWoncA2yNwzFLlbByOck4qtv4Ef
UURqVXDk5Ozv8OjSqd601zSbyuVFn/Uy4TQaFk2N8D85y3nK8ntcj7zub3rddCti
ZSRtKVjAxY+rQstA2N8OxP5eEfWYiWhngOiGtSd+mS0ykCmrCzDr0mHYxPpM+MM5
RIrXHNyFJAtDa6vkx9MpQ1An9hf4qmTuXpoWrxqZMa8kAE6ixn6117Y2wtLMeDqM
QYY7JmCMTdzONy5HDx0hUiMCAwEAAQ==
-----END PUBLIC KEY-----]]
```

## Launch

```
openresty -c $HOME/ethrpc-jwt-proxy/nginx.conf -g 'daemon off;'
```

## Example systemd unit

```
[Unit]
Description=Proxy

[Service]
EnvironmentFile=/root/env
Type=simple
ExecStart=/usr/bin/openresty -c /home/wetrustroot/ethrpc-jwt-proxy/nginx.conf -g 'daemon off;'

[Install]
WantedBy=default.target
```

With env file:

```
LUA_PATH=/path/to/ethrpc-jwt-proxy/?.lua;/usr/local/share/lua/5.1/?.lua;;
```

## Test

Generate a token on https://jwt.io/ using `RS256` and your private key, then attach geth like this:

```
geth attach http://localhost:8089/<your jwt here>
```

## Payload validation

You can check the payload claims this way in nginx.conf:

```
jwt.auth({
    aud="http://chainz%-node%-rinkeby.centralus.cloudapp.azure.com",
})
```

Strings must follow [lua pattern](https://www.lua.org/pil/20.2.html) escaping convention.
