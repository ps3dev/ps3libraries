#!/usr/bin/env bash
set -eo pipefail
# libcurl-7.31.0 by KaKaRoTo
# modified by mhaqs for 7.31.0 release and cpp compatibility

VERSION="7.64.1"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh curl-${VERSION}.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf curl-${VERSION}
echo "Unpacking curl-${VERSION}"
extract ../archives/curl-${VERSION}.tar.gz
cd curl-${VERSION}

## Replace config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
AR="ppu-ar" CC="ppu-gcc" RANLIB="ppu-ranlib" \
  CFLAGS="-O2 -Wall" \
  CXXFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
  CPPFLAGS=" -I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include -I$PSL1GHT/ppu/include/net"  \
  LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib" LIBS="-lnet -lsysutil -lsysmodule -lm " \
  PKG_CONFIG_LIBDIR="$PSL1GHT/ppu/lib/pkgconfig" PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
     ../configure   --prefix="$PS3DEV/portlibs/ppu"  --host="powerpc64-ps3-elf"  \
          --disable-threaded-resolver --disable-ipv6 \
          --includedir="$PS3DEV/portlibs/ppu/include"   --libdir="$PS3DEV/portlibs/ppu/lib" --without-ssl --with-polarssl="$PS3DEV/portlibs/ppu/include/polarssl" --with-ca-bundle="/usr/ssl/certs/ca-bundle.crt"

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
