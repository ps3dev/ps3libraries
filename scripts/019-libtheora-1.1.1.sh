#!/bin/sh -e
# libtheora-1.1.1.sh by dhewg (dhewg@wiibrew.org)

## Download the source code.
wget --continue http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2

## Unpack the source code.
rm -Rf libtheora-1.1.1 && tar xfvj libtheora-1.1.1.tar.bz2 && cd libtheora-1.1.1

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared --disable-examples

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
