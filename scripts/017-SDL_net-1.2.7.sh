#!/usr/bin/env bash
set -eo pipefail

# SDL_net-1.2.7.sh
SDL_NET="SDL_net-1.2.7"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL_NET}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${SDL_NET}
echo "Unpacking ${SDL_NET}"
extract ../archives/${SDL_NET}.tar.gz
cd ${SDL_NET}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub .

## Patch the source code.
cat ../../patches/${SDL_NET}.patch | patch -p1

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PSL1GHT/ppu/include/SDL -I$PS3DEV/portlibs/ppu/include -I$PS3DEV/portlibs/ppu/include/SDL" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
./configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" \
    --disable-sdltest \
    --with-sdl-exec-prefix="$PS3DEV/portlibs/ppu" \
    --disable-shared \
    --enable-static

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
