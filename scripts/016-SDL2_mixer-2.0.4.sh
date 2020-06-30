#!/bin/sh -e

## Download the source code.
../download.sh SDL2_mixer-2.0.4.tar.gz

## Download an up-to-date config.guess and config.sub
../download.sh config.guess
../download.sh config.sub

## Unpack the source code.
rm -Rf SDL2_mixer-2.0.4 && tar xfvz ../archives/SDL2_mixer-2.0.4.tar.gz && cd SDL2_mixer-2.0.4

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub build-scripts/

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
LIBMIKMOD_CONFIG="$PS3DEV/portlibs/ppu/bin/libmikmod-config"
export LIBMIKMOD_CONFIG
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" \
    --disable-sdltest \
    --with-sdl-exec-prefix="$PS3DEV/portlibs/ppu" \
    --disable-shared \
    --disable-music-cmd \
    --disable-music-ogg-shared \
    --disable-music-mp3 \
    --disable-music-flac

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
