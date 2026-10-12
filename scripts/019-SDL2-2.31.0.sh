#!/usr/bin/env bash
set -eo pipefail

# SDL2-2.31.0.sh — official SDL2 2.30.1 with PSL1GHT PPU patch (reports 2.31.0)
SDL2="SDL2-2.30.1"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL2}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${SDL2}
echo "Unpacking ${SDL2}"
extract ../archives/${SDL2}.tar.gz
cd ${SDL2}

## Patch the source code.
cat ../../patches/${SDL2}-PPU.patch | patch -p1

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub build-scripts/

## Configure the build.
./autogen.sh
CFLAGS="-O2 -Wall -I$PSL1GHT/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -lrt -llv2" \
./configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" \
    --enable-atomic=yes \
    --enable-video-psl1ght=yes \
    --enable-joystick=yes \
    --enable-audio=yes

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
