#!/bin/sh -e
# yaml-cpp-0.8.0.sh by Humberto Dias

## Download the source code.
wget https://github.com/jbeder/yaml-cpp/archive/refs/tags/0.8.0.tar.gz -O yaml-cpp.tar.gz

## Unpack the source code.
rm -Rf yaml-cpp && mkdir yaml-cpp && tar --strip-components=1 --directory=yaml-cpp -xvzf yaml-cpp.tar.gz

## Create the build directory.
cd yaml-cpp

## Compile and install.
mkdir -p build && cd build
cmake -Wno-dev \
    -DCMAKE_INSTALL_PREFIX=${PS3DEV}/portlibs/ppu \
    -DCMAKE_C_COMPILER=ppu-gcc \
    -DCMAKE_CXX_COMPILER=ppu-g++ \
    -DBUILD_SHARED_LIBS=OFF -DYAML_ENABLE_PIC=OFF -DYAML_CPP_INSTALL=ON  .. || { exit 1; }
make && make install || { exit 1; }