# redis-luajit
Redis support luajit based on project https://github.com/coleifer/redis-luajit
- Using luajit2 of openresty team: https://github.com/openresty/luajit2
- Replace lua-cjson with lua-cjson of openresty team: https://github.com/openresty/lua-cjson

# How to
```sh
wget http://download.redis.io/releases/redis-5.0.5.tar.gz

tar xvzf redis-5.0.5.tar.gz

cd redis-5.0.5

./patch_redis_luajit.sh

make install
```

