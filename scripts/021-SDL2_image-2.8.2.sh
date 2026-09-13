#!/usr/bin/env bash
set -eo pipefail

# SDL2_image-2.8.2.sh
SDL2_IMAGE="SDL2_image-2.8.2"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL2_IMAGE}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${SDL2_IMAGE}
echo "Unpacking ${SDL2_IMAGE}"
extract ../archives/${SDL2_IMAGE}.tar.gz
cd ${SDL2_IMAGE}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub .
[ -d build-scripts ] && cp ../../archives/config.guess ../../archives/config.sub build-scripts/

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_LIBDIR="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
./configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" \
    --disable-sdltest \
    --with-sdl-exec-prefix="$PS3DEV/portlibs/ppu" \
    --disable-shared \
    --disable-avif \
    --disable-jxl \
    --disable-tif \
    --disable-webp \
    --enable-static \
    SDL_CFLAGS="`$PS3DEV/portlibs/ppu/bin/sdl2-config --cflags`" \
    LIBPNG_CFLAGS="`$PS3DEV/portlibs/ppu/bin/libpng-config --cflags`" \
    LIBPNG_LIBS="`$PS3DEV/portlibs/ppu/bin/libpng-config --libs`"

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
