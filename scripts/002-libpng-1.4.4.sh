#!/bin/sh
# libpng-1.4.4.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://sourceforge.net/projects/libpng/files/01-libpng-master/1.4.4/libpng-1.4.4.tar.gz/download -O libpng-1.4.4.tar.gz || { exit 1; }

## Unpack the source code.
rm -Rf libpng-1.4.4 && tar xfvz libpng-1.4.4.tar.gz && cd libpng-1.4.4 || { exit 1; }

## Patch the source code.
cat ../../patches/libpng-1.4.4-PPU.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
CFLAGS="-O2 -Wall -L$PS3DEV/ppu/lib" CPPFLAGS="-I$PS3DEV/ppu/include" ../configure --prefix="$PS3DEV/ppu" --host="ppu" || { exit 1; }

## Compile and install.
make -j4 && make install || { exit 1; }
