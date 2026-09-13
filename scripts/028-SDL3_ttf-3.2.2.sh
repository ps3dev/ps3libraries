#!/usr/bin/env bash
set -eo pipefail

# SDL3_ttf-3.2.2.sh
SDL3_TTF="SDL3_ttf-3.2.2"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SDL3_TTF}.tar.gz

install_ps3_cmake_toolchain

## Unpack the source code.
rm -Rf ${SDL3_TTF}
echo "Unpacking ${SDL3_TTF}"
extract ../archives/${SDL3_TTF}.tar.gz
cd ${SDL3_TTF}

## Patch the source code.
cat ../../patches/SDL3_ttf-1.patch | patch -p1

# Download vendored libs
./external/download.sh

mkdir -p build-ppc
cd build-ppc

cmake_ppu -C "$PS3LIBRARIES_ROOT/cmake/sdl3.cmake" ..
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
cmake --build . --parallel "$jobs"
cmake --install .
