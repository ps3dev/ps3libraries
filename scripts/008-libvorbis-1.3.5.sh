#!/bin/sh -e
# libvorbis-1.3.5.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
../download.sh libvorbis-1.3.5.tar.gz

## Download an up-to-date config.guess and config.sub
../download.sh config.guess
../download.sh config.sub

## Unpack the source code.
rm -Rf libvorbis-1.3.5 && tar xfvz ../archives/libvorbis-1.3.5.tar.gz && cd libvorbis-1.3.5

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
