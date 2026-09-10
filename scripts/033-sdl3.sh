#!/usr/bin/env bash
set -eo pipefail
# SDL3 by 16rom.com

SDL3="SDL3_3.4.14"
## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh sdl3.tar.gz

## Unpack the source code.
rm -Rf ${SDL3}
mkdir ${SDL3}
echo "Unpacking ${SDL3}"
extract ../archives/sdl3.tar.gz --strip-components=1 --directory=${SDL3}
cd ${SDL3}
mkdir -p build-ppc
cd build-ppc

cmake -DCMAKE_TOOLCHAIN_FILE="../../cmake/ps3-toolchain.cmake" -DCMAKE_BUILD_TYPE=Release  ..
cmake --build . 
cmake --install .
