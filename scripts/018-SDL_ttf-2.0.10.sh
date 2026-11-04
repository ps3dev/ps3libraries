#!/usr/bin/env bash
set -eo pipefail

# SDL_ttf-2.0.10.sh
SDL_TTF="SDL_ttf-2.0.10"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL_TTF}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${SDL_TTF}
echo "Unpacking ${SDL_TTF}"
extract ../archives/${SDL_TTF}.tar.gz
cd ${SDL_TTF}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub .

## Patch the source code.
cat ../../patches/${SDL_TTF}.patch | patch -p1

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PSL1GHT/ppu/include/SDL -I$PS3DEV/portlibs/ppu/include -I$PS3DEV/portlibs/ppu/include/SDL -I$PS3DEV/portlibs/ppu/include/freetype2" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
./configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" \
    --with-freetype-exec-prefix="$PS3DEV/portlibs/ppu" \
    --with-sdl-exec-prefix="$PS3DEV/portlibs/ppu" \
    --without-x \
    --disable-sdltest \
    --enable-static

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
