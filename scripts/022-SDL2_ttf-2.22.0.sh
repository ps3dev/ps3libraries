#!/usr/bin/env bash
set -eo pipefail

# SDL2_ttf-2.22.0.sh
SDL2_TTF="SDL2_ttf-2.22.0"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL2_TTF}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${SDL2_TTF}
echo "Unpacking ${SDL2_TTF}"
extract ../archives/${SDL2_TTF}.tar.gz
cd ${SDL2_TTF}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub .
[ -d build-scripts ] && cp ../../archives/config.guess ../../archives/config.sub build-scripts/

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include -I$PS3DEV/portlibs/ppu/include/freetype2" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
./configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" \
    --with-freetype-exec-prefix="$PS3DEV/portlibs/ppu" \
    --with-sdl-exec-prefix="$PS3DEV/portlibs/ppu" \
    --without-x \
    --disable-sdltest \
    --disable-harfbuzz \
    --disable-shared \
    --enable-static

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
