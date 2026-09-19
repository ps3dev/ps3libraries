#!/usr/bin/env bash
set -eo pipefail
# yaml-cpp-0.9.0.sh by Humberto Dias

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh yaml-cpp.tar.gz

## Unpack the source code.
rm -Rf yaml-cpp
mkdir yaml-cpp
echo "Unpacking yaml-cpp"
extract ../archives/yaml-cpp.tar.gz --strip-components=1 --directory=yaml-cpp
cd yaml-cpp

## Compile and install.
mkdir -p build
cd build
cmake -Wno-dev \
    -DCMAKE_SYSTEM_NAME=Generic \
    -DCMAKE_SYSTEM_PROCESSOR=powerpc64 \
    -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY \
    -DCMAKE_INSTALL_PREFIX="${PS3DEV}/portlibs/ppu" \
    -DCMAKE_C_COMPILER=ppu-gcc \
    -DCMAKE_CXX_COMPILER=ppu-g++ \
    -DBUILD_SHARED_LIBS=OFF \
    -DYAML_BUILD_SHARED_LIBS=OFF \
    -DYAML_ENABLE_PIC=OFF \
    -DYAML_CPP_BUILD_TOOLS=OFF \
    -DYAML_CPP_BUILD_TESTS=OFF \
    -DYAML_CPP_INSTALL=ON \
    ..
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" yaml-cpp
${MAKE:-make} -j"$jobs" install
