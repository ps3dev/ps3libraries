#!/bin/sh -e
# zlib-1.2.7.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://zlib.net/zlib-1.2.7.tar.gz

## Unpack the source code.
rm -Rf zlib-1.2.7 && tar xfvz zlib-1.2.7.tar.gz && cd zlib-1.2.7

## Patch the source code.
cat ../../patches/zlib-1.2.7-PPU.patch | patch -p1

## Configure the build.
AR="powerpc64-ps3-elf-ar" CC="powerpc64-ps3-elf-gcc" RANLIB="powerpc64-ps3-elf-ranlib" \
./configure --prefix="$PS3DEV/portlibs/ppu" --static

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
