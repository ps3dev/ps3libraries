#!/usr/bin/env bash
set -eo pipefail

# cairo-1.10.0.sh by Naomi Peori (naomi@peori.ca)
CAIRO="cairo-1.10.0"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${CAIRO}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf ${CAIRO}
echo "Unpacking ${CAIRO}"
extract ../archives/${CAIRO}.tar.gz
cd ${CAIRO}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub build/

## Patch the source code.
cat ../../patches/${CAIRO}.patch | patch -p1

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include -DCAIRO_NO_MUTEX" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --enable-fc="no" --enable-xlib="no" --disable-shared --disable-valgrind --enable-gobject="no"

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
