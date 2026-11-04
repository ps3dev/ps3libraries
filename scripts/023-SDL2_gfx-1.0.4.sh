#!/usr/bin/env bash
set -eo pipefail

# SDL2_gfx-1.0.4.sh
SDL2_GFX="SDL2_gfx-1.0.4"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL2_GFX}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${SDL2_GFX}
echo "Unpacking ${SDL2_GFX}"
extract ../archives/${SDL2_GFX}.tar.gz
cd ${SDL2_GFX}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub .

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
./configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" \
    --with-sdl-exec-prefix="$PS3DEV/portlibs/ppu" \
    --disable-sdltest \
    --disable-mmx \
    --disable-shared \
    --enable-static

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
aclocal_kluge='am__aclocal_m4_deps='
${MAKE:-make} -j"$jobs" $aclocal_kluge
${MAKE:-make} -j"$jobs" $aclocal_kluge install
