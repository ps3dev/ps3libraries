#!/bin/bash -e
# libmikmod-3.1.11.sh by Marcus Comstedt <marcus@mc.pp.se>

## Download the source code.
wget --continue http://mikmod.raphnet.net/files/libmikmod-3.1.11.tar.gz

## Unpack the source code.
rm -Rf libmikmod-3.1.11 && tar xfvz ./libmikmod-3.1.11.tar.gz && cd libmikmod-3.1.11

## Patch the source code.
cat ../../patches/libmikmod-3.1.11-PPU.patch | patch -p1

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
CC="ppu-gcc" LD="ppu-ld" NM="ppu-nm" RANLIB="ppu-ranlib" STRIP="ppu-strip" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="ppu" --disable-esd --disable-dl --disable-shared

## Compile and install.
${MAKE:-make} && ${MAKE:-make} install
