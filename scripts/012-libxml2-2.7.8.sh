#!/bin/sh -e
# libxml2-2.7.8.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue ftp://xmlsoft.org/libxml2/libxml2-2.7.8.tar.gz

## Unpack the source code.
rm -Rf libxml2-2.7.8 && tar xfvz libxml2-2.7.8.tar.gz && cd libxml2-2.7.8

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --enable-static --disable-shared --without-ftp --without-http --without-python

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
