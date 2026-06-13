#!/usr/bin/env bash
set -eo pipefail

# freetype-2.4.3.sh by Naomi Peori (naomi@peori.ca)
FREETYPE="freetype-2.4.3"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${FREETYPE}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${FREETYPE}
echo "Unpacking ${FREETYPE}"
extract ../archives/${FREETYPE}.tar.gz
cd ${FREETYPE}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub builds/unix/

## Create the build directory.
mkdir build-ppu && cd build-ppu

## freetype insists on GNU make
which gmake 1>/dev/null 2>&1 && MAKE=gmake

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
GNUMAKE=$MAKE ../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
