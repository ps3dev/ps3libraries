#!/usr/bin/env bash
set -eo pipefail

# tiff-3.9.4.sh by Jon Limle <jonlimle123@yahoo.com>
TIFF="tiff-3.9.4"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${TIFF}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${TIFF}
echo "Unpacking ${TIFF}"
extract ../archives/${TIFF}.tar.gz
cd ${TIFF}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub config/

## Patch the source code.
cat ../../patches/${TIFF}-PPU.patch | patch -p1

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
