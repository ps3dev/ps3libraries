#!/bin/sh -e
# libvorbis-1.3.2.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.2.tar.gz

## Unpack the source code.
rm -Rf libvorbis-1.3.2 && tar xfvz libvorbis-1.3.2.tar.gz && cd libvorbis-1.3.2

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
