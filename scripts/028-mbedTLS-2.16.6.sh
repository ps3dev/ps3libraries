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
VERSION="2.16.6"
#
###########################################################################
#
# Don't change anything here

CURRENTPATH=`pwd`
ARCH="powerpc64"
PLATFORM="PS3"

## Download the source code.
wget -O mbedtls-${VERSION}.gpl.tgz http://downloads.arednmesh.org/sources/mbedtls-${VERSION}-gpl.tgz

## Unpack the source code.
rm -Rf mbedtls-${VERSION} && tar xfvz mbedtls-${VERSION}.gpl.tgz && cd mbedtls-${VERSION}

echo "Building mbedTLS ${VERSION} for ${PLATFORM} ${ARCH}"

echo "Patching Makefile..."
sed -i.bak '4d' ${CURRENTPATH}/mbedtls-${VERSION}/library/Makefile

echo "Please stand by..."

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
export CFLAGS="-I${CURRENTPATH}/mbedtls-${VERSION}/include -I$PS3DEV/ppu/powerpc64-ps3-elf/include -I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include -mcpu=cell"
export MBEDTLS_NO_PLATFORM_ENTROPY=1

## Create config.h file
cd library
sed -i.bak '94d' ../configs/config-no-entropy.h
sed -i.bak '92d' ../configs/config-no-entropy.h
cp ../configs/config-no-entropy.h ../include/mbedtls/config.h
echo "#define MBEDTLS_KEY_EXCHANGE_RSA_ENABLED
#define MBEDTLS_KEY_EXCHANGE_PSK_ENABLED
#define MBEDTLS_KEY_EXCHANGE_RSA_PSK_ENABLED
#define MBEDTLS_KEY_EXCHANGE_DHE_PSK_ENABLED
#define MBEDTLS_KEY_EXCHANGE_DHE_RSA_ENABLED
#define MBEDTLS_KEY_EXCHANGE_ECDH_RSA_ENABLED
#define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
#define MBEDTLS_KEY_EXCHANGE_ECDHE_RSA_ENABLED
#define MBEDTLS_KEY_EXCHANGE_ECDHE_PSK_ENABLED
#define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
#define MBEDTLS_KEY_EXCHANGE_ECJPAKE_ENABLED
#define MBEDTLS_SSL_PROTO_DTLS
#define MBEDTLS_SSL_PROTO_SSL3
#define MBEDTLS_SSL_PROTO_TLS1
#define MBEDTLS_SSL_PROTO_TLS1_1
#define MBEDTLS_SSL_PROTO_TLS1_2
#define MBEDTLS_SHA1_C
#define MBEDTLS_MD5_C
#define MBEDTLS_DHM_C
#define MBEDTLS_ECDH_C
#define MBEDTLS_ECJPAKE_C
#define MBEDTLS_SSL_CLI_C
#define MBEDTLS_SSL_SRV_C
#define MBEDTLS_SSL_TLS_C

#include \"check_config.h\"

#endif /* MBEDTLS_CONFIG_H */" >> ../include/mbedtls/config.h

echo "Build library..."
## Compile and install.
${MAKE:-make}

cp lib*.a $PS3DEV/portlibs/ppu/lib/
cp -R ../include/mbedtls $PS3DEV/portlibs/ppu/include/
cp ../LICENSE $PS3DEV/portlibs/ppu/include/mbedtls/LICENSE

echo "Building done."
