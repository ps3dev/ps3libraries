#!/bin/sh -e
# flac-1.2.1.sh by dhewg (dhewg@wiibrew.org)

## Download the source code.
wget --continue http://downloads.sourceforge.net/project/flac/flac-src/flac-1.2.1-src/flac-1.2.1.tar.gz

## Unpack the source code.
rm -Rf flac-1.2.1 && tar xfvz flac-1.2.1.tar.gz && cd flac-1.2.1

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared --enable-altivec --disable-xmms-plugin --disable-ogg --disable-oggtest

## Compile (only parts to prevent failures in unrequired parts) and install.
${MAKE:-make} -C src/libFLAC -j4 && ${MAKE:-make} -C src/libFLAC install && ${MAKE:-make} -C include install
