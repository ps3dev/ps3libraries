#!/usr/bin/env bash
set -eo pipefail

# SDL3_mixer-3.2.4.sh
SDL3_MIXER="SDL3_mixer-3.2.4"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL3_MIXER}.tar.gz

install_ps3_cmake_toolchain

## Unpack the source code.
rm -Rf ${SDL3_MIXER}
echo "Unpacking ${SDL3_MIXER}"
extract ../archives/${SDL3_MIXER}.tar.gz
cd ${SDL3_MIXER}

mkdir -p build-ppc
cd build-ppc

cmake_ppu -C "$PS3LIBRARIES_ROOT/cmake/sdl3.cmake" ..
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
cmake --build . --parallel "$jobs"
cmake --install .
