#!/bin/sh -e
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
CC="powerpc64-ps3-elf-gcc" LD="powerpc64-ps3-elf-ld" NM="powerpc64-ps3-elf-nm" \
RANLIB="powerpc64-ps3-elf-ranlib" STRIP="powerpc64-ps3-elf-strip" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" \
--disable-esd --disable-dl --disable-shared

## Compile and install.
${MAKE:-make} && ${MAKE:-make} install
