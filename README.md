# ethrpc-jwt-proxy

ethrpc-jwt-proxy is an HTTP proxy that restrict access to the RPC interface of ethereum clients like geth

It is based https://github.com/auth0/nginx-jwt with minor modifications to get the JWT from the query string

## Setup on Ubuntu

```
git clone git@github.com:WeTrustPlatform/ethrpc-jwt-proxy.git
sudo add-apt-repository ppa:openresty/ppa
sudo apt-get update
sudo apt-get install openresty luarocks
luarocks install lua-resty-jwt
luarocks install basexx
```

## Setup on OSX

```
git clone git@github.com:WeTrustPlatform/ethrpc-jwt-proxy.git
brew install openresty/brew/openresty
brew install lua
luarocks install lua-resty-jwt
luarocks install basexx
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

```
export LUA_PATH="$HOME/ethrpc-jwt-proxy/?.lua;/usr/local/Cellar/lua/5.3.4_4/share/lua/5.3/?.lua;;"
export JWT_SECRET=`cat jwtRS256.key.pub`
export JWT_SECRET_IS_BASE64_ENCODED=false
```

## Launch

```
openresty -c $HOME/ethrpc-jwt-proxy/nginx.conf -g 'daemon off;'
```

## Test

Generate a token on https://jwt.io/ using `RS256` and your private key, then attach geth like this:

```
geth attach http://localhost:8088/<your jwt here>
```
