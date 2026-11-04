#!/usr/bin/env bash
set -eo pipefail

# SDL-1.2.15.sh — official SDL 1.2.15 from libsdl-org/SDL-1.2 with PPU patch
SDL="SDL-1.2.15"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${SDL}
mkdir ${SDL}
echo "Unpacking ${SDL}"
extract ../archives/${SDL}.tar.gz --strip-components=1 --directory=${SDL}
cd ${SDL}

## Patch the source code.
cat ../../patches/${SDL}-PPU.patch | patch -p1

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub build-scripts/

## Configure the build.
./autogen.sh
CFLAGS="-O2 -Wall -I$PSL1GHT/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -lrt -llv2" \
./configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" \
    --disable-shared \
    --enable-static \
    --without-x \
    --disable-video-x11 \
    --disable-video-ps3 \
    --disable-nasm \
    --enable-joystick \
    --enable-audio

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
