#!/usr/bin/env bash
set -eo pipefail

SDL2_MIXER="SDL2_mixer-2.0.4"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL2_MIXER}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${SDL2_MIXER}
echo "Unpacking ${SDL2_MIXER}"
extract ../archives/${SDL2_MIXER}.tar.gz
cd ${SDL2_MIXER}

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
    --disable-music-flac \
    --disable-music-mod-modplug \
    --enable-music-mod-mikmod

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
