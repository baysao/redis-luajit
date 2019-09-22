#!/bin/sh
sed '/luaopen_debug/i luaLoadLib(lua, LUA_JITLIBNAME, luaopen_jit);\nluaLoadLib(lua, LUA_FFILIBNAME, luaopen_ffi);' -i src/scripting.c

sed 's/cd lua/cd luajit2/g' deps/Makefile -i
sed 's/lua\/src/luajit2\/src/g' src/Makefile -i 
sed 's/liblua.a/libluajit.a/g' src/Makefile -i
cd deps
if [ ! -d "lua-cjson" ];then
	git clone https://github.com/openresty/lua-cjson.git
fi
cd lua-cjson;git pull;cd -
if [ ! -d "luajit2" ];then
	git clone https://github.com/openresty/luajit2.git
fi
cd luajit2;git pull;cd -
cp -rf lua/src/lua_* luajit2/src/
cp -rf lua-cjson/*.c lua-cjson/*.h luajit2/src/
sed 's/^XCFLAGS=/XCFLAGS=-DENABLE_CJSON_GLOBAL/' -i luajit2/src/Makefile
sed 's/lib_ffi.o/lib_ffi.o fpconv.o lua_cjson.o lua_cmsgpack.o lua_struct.o strbuf.o/' -i luajit2/src/Makefile
sed 's/<lua.h>/"lua.h"/' -i luajit2/src/lua_cjson.c
sed 's/<lauxlib.h>/"lauxlib.h"/' -i luajit2/src/lua_cjson.c
