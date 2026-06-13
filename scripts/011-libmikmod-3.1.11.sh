#!/usr/bin/env bash
set -eo pipefail

# libmikmod-3.1.11.sh by Marcus Comstedt <marcus@mc.pp.se>
LIBMIKMOD="libmikmod-3.1.11"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${LIBMIKMOD}.tar.gz

## Unpack the source code.
rm -Rf ${LIBMIKMOD}
echo "Unpacking ${LIBMIKMOD}"
extract ../archives/${LIBMIKMOD}.tar.gz
cd ${LIBMIKMOD}

## Patch the source code.
cat ../../patches/${LIBMIKMOD}-PPU.patch | patch -p1

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
CC="powerpc64-ps3-elf-gcc" AR="powerpc64-ps3-elf-ar" LD="powerpc64-ps3-elf-ld" NM="powerpc64-ps3-elf-nm" \
RANLIB="powerpc64-ps3-elf-ranlib" STRIP="powerpc64-ps3-elf-strip" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" \
--disable-esd --disable-dl --disable-shared

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
