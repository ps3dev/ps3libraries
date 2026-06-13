#!/usr/bin/env bash
set -eo pipefail

# zlib-1.2.13.sh by Naomi Peori (naomi@peori.ca)
ZLIB="zlib-1.2.13"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${ZLIB}.tar.gz

## Unpack the source code.
rm -Rf ${ZLIB}
echo "Unpacking ${ZLIB}"
extract ../archives/${ZLIB}.tar.gz
cd ${ZLIB}

## Patch the source code.
cat ../../patches/${ZLIB}-PPU.patch | patch -p1

## Configure the build.
AR="powerpc64-ps3-elf-ar" CC="powerpc64-ps3-elf-gcc" RANLIB="powerpc64-ps3-elf-ranlib" \
./configure --prefix="$PS3DEV/portlibs/ppu" --static

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" AR="powerpc64-ps3-elf-ar" ARFLAGS="rc" RANLIB="powerpc64-ps3-elf-ranlib"
${MAKE:-make} -j"$jobs" install AR="powerpc64-ps3-elf-ar" ARFLAGS="rc" RANLIB="powerpc64-ps3-elf-ranlib"
