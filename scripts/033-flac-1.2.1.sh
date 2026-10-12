#!/usr/bin/env bash
set -eo pipefail
# flac-1.2.1.sh by dhewg (dhewg@wiibrew.org)
FLAC="flac-1.2.1"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${FLAC}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${FLAC}
echo "Unpacking ${FLAC}"
extract ../archives/${FLAC}.tar.gz
cd ${FLAC}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared --enable-altivec --disable-xmms-plugin --disable-ogg --disable-oggtest

## Compile (only parts to prevent failures in unrequired parts) and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -C src/libFLAC -j"$jobs" && ${MAKE:-make} -j"$jobs" -C src/libFLAC install && ${MAKE:-make} -j"$jobs" -C include install
