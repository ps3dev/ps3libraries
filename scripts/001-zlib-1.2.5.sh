#!/bin/sh
# zlib-1.2.5.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://zlib.net/zlib-1.2.5.tar.gz || { exit 1; }

## Unpack the source code.
rm -Rf zlib-1.2.5 && tar xfvz zlib-1.2.5.tar.gz && cd zlib-1.2.5 || { exit 1; }

## Configure the build.
CC="ppu-gcc" RANLIB="ppu-ranlib" AR="ppu-ar" CFLAGS="-O2 -Wall" ./configure --prefix="$PS3DEV/ppu" || { exit 1; }

## Compile and install.
make -j4 && make install || { exit 1; }
