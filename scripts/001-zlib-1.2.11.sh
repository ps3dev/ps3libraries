#!/bin/sh -e
# zlib-1.2.11.sh by Naomi Peori (naomi@peori.ca)
ZLIB="zlib-1.2.13"

## Download the source code.
wget --continue https://github.com/madler/zlib/releases/download/v1.2.13/${ZLIB}.tar.gz

## Unpack the source code.
rm -Rf ${ZLIB} && tar xfvz ${ZLIB}.tar.gz && cd ${ZLIB}

## Patch the source code.
cat ../../patches/${ZLIB}-PPU.patch | patch -p1

## Configure the build.
AR="powerpc64-ps3-elf-ar" CC="powerpc64-ps3-elf-gcc" RANLIB="powerpc64-ps3-elf-ranlib" \
./configure --prefix="$PS3DEV/portlibs/ppu" --static

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
