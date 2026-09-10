#!/usr/bin/env bash
set -eo pipefail
# SDL3 by 16rom.com

SDL3_MIXER="SDL3_mixer_3.2.4"
## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh SDL3_mixer-3.2.4.tar.gz

## Unpack the source code.
rm -Rf ${SDL3_MIXER}
mkdir ${SDL3_MIXER}
echo "Unpacking ${SDL3_MIXER}"
extract ../archives/SDL3_mixer-3.2.4.tar.gz --strip-components=1 --directory=${SDL3_MIXER}
cd ${SDL3_MIXER}
mkdir -p build-ppc
cd build-ppc

cmake -DCMAKE_TOOLCHAIN_FILE="../../cmake/ps3-toolchain.cmake" -DCMAKE_BUILD_TYPE=Release  ..
cmake --build . 
cmake --install .
