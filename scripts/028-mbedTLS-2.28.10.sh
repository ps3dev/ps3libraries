#!/bin/sh -e

# Update by Damian Parrino (2020-07-29)
# Automatic build script for mbedTLS
# for PSL1GHT, PlayStation 3 open source SDK.
#
# Originally Created by Felix Schulze on 08.04.11.
# Ported to PS3Libraries to compile with psl1ght.
# Copyright 2010 Felix Schulze. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
###########################################################################
# Change values here
#
VERSION="2.28.10"
#
###########################################################################
#
# Don't change anything here

CURRENTPATH=`pwd`
ARCH="powerpc64"
PLATFORM="PS3"

## Download the source code.
../download.sh mbedtls-${VERSION}.tar.bz2

## Unpack the source code.
rm -Rf mbedtls-${VERSION} && tar xfvz ../archives/mbedtls-${VERSION}.tar.bz2 && cd mbedtls-${VERSION}

echo "Building mbedTLS ${VERSION} for ${PLATFORM} ${ARCH}"

echo "Patching Makefile..."
patch -p1 < ../patches/mbedtls-${VERSION}.patch

TOOLCHAIN_PATH=$PS3DEV/ppu/bin/powerpc64-ps3-elf-
export CC=${TOOLCHAIN_PATH}gcc
export LD=${TOOLCHAIN_PATH}ld
export CPP=${TOOLCHAIN_PATH}cpp
export CXX=${TOOLCHAIN_PATH}g++
export AR=${TOOLCHAIN_PATH}ar
export AS=${TOOLCHAIN_PATH}as
export NM=${TOOLCHAIN_PATH}nm
export CXXCPP=${TOOLCHAIN_PATH}cpp
export RANLIB=${TOOLCHAIN_PATH}ranlib
export LDFLAGS="-L$PS3DEV/ppu/powerpc64-ps3-elf/lib -L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2"
export CFLAGS="-I../include -I$PS3DEV/ppu/powerpc64-ps3-elf/include -I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include -mcpu=cell"

echo "Build library..."
## Compile and install.
cd library
${MAKE:-make}

cp lib*.a $PS3DEV/portlibs/ppu/lib/
cp -R ../include/mbedtls $PS3DEV/portlibs/ppu/include/
cp ../LICENSE $PS3DEV/portlibs/ppu/include/mbedtls/LICENSE

echo "Building done."
