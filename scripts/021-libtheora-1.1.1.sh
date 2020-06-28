#!/bin/sh -e
# libtheora-1.1.1.sh by dhewg (dhewg@wiibrew.org)

## Download the source code.
../download.sh libtheora-1.1.1.tar.bz2

## Download an up-to-date config.guess and config.sub
../download.sh config.guess
../download.sh config.sub

## Unpack the source code.
rm -Rf libtheora-1.1.1 && tar xfvj ../archives/libtheora-1.1.1.tar.bz2 && cd libtheora-1.1.1

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared --disable-examples

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
