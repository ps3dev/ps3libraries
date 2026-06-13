#!/usr/bin/env bash
set -eo pipefail

# libvorbis-1.3.5.sh by Naomi Peori (naomi@peori.ca)
LIBVORBIS="libvorbis-1.3.5"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${LIBVORBIS}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${LIBVORBIS}
echo "Unpacking ${LIBVORBIS}"
extract ../archives/${LIBVORBIS}.tar.gz
cd ${LIBVORBIS}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
