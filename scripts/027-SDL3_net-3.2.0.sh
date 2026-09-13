#!/usr/bin/env bash
set -eo pipefail

# SDL3_net-3.2.0.sh
SDL3_NET="SDL3_net-3.2.0"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL3_NET}.tar.gz

install_ps3_cmake_toolchain

## Unpack the source code.
rm -Rf ${SDL3_NET}
echo "Unpacking ${SDL3_NET}"
extract ../archives/${SDL3_NET}.tar.gz
cd ${SDL3_NET}

## Patch the source code.
cat ../../patches/SDL3_net-1.patch | patch -p1

mkdir -p build-ppc
cd build-ppc

cmake_ppu -C "$PS3LIBRARIES_ROOT/cmake/sdl3.cmake" ..
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
cmake --build . --parallel "$jobs"
cmake --install .
