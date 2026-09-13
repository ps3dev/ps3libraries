#!/usr/bin/env bash
set -eo pipefail

# SDL3-3.5.0.sh — official SDL3 3.5.0 snapshot with PSL1GHT PPU patch
SDL3="SDL3-3.5.0"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL3}.tar.gz

install_ps3_cmake_toolchain

## Unpack the source code.
rm -Rf ${SDL3}
mkdir ${SDL3}
echo "Unpacking ${SDL3}"
extract ../archives/${SDL3}.tar.gz --strip-components=1 --directory=${SDL3}
cd ${SDL3}

## Patch the source code.
cat ../../patches/${SDL3}-PPU.patch | patch -p1

mkdir -p build-ppc
cd build-ppc

cmake_ppu -C "$PS3LIBRARIES_ROOT/cmake/sdl3.cmake" ..
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
cmake --build . --parallel "$jobs"
cmake --install .
