#!/usr/bin/env bash
set -eo pipefail

# SDL3_gfx-1.0.1.sh — sabdul-khabir/SDL3_gfx with PPU CMake patch
SDL3_GFX="SDL3_gfx-1.0.1"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL3_GFX}.tar.gz

install_ps3_cmake_toolchain

## Unpack the source code.
rm -Rf ${SDL3_GFX}
mkdir ${SDL3_GFX}
echo "Unpacking ${SDL3_GFX}"
extract ../archives/${SDL3_GFX}.tar.gz --strip-components=1 --directory=${SDL3_GFX}
cd ${SDL3_GFX}

## Patch the source code.
cat ../../patches/SDL3_gfx-1.patch | patch -p1

mkdir -p build-ppc
cd build-ppc

cmake_ppu -C "$PS3LIBRARIES_ROOT/cmake/sdl3.cmake" ..
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
cmake --build . --parallel "$jobs"
cmake --install .
