#!/usr/bin/env bash
set -eo pipefail
# libtheora-1.1.1.sh by dhewg (dhewg@wiibrew.org)
LIBTHEORA="libtheora-1.1.1"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${LIBTHEORA}.tar.bz2

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${LIBTHEORA}
echo "Unpacking ${LIBTHEORA}"
extract ../archives/${LIBTHEORA}.tar.bz2
cd ${LIBTHEORA}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared --disable-examples

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
