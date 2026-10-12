#!/usr/bin/env bash
set -eo pipefail

# SDL3_image-3.4.6.sh
SDL3_IMAGE="SDL3_image-3.4.6"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL3_IMAGE}.tar.gz

install_ps3_cmake_toolchain

## Unpack the source code.
rm -Rf ${SDL3_IMAGE}
echo "Unpacking ${SDL3_IMAGE}"
extract ../archives/${SDL3_IMAGE}.tar.gz
cd ${SDL3_IMAGE}

## Patch the source code.
cat ../../patches/SDL3_image-1.patch | patch -p1

mkdir -p build-ppc
cd build-ppc

cmake_ppu -C "$PS3LIBRARIES_ROOT/cmake/sdl3.cmake" ..
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
cmake --build . --parallel "$jobs"
cmake --install .
