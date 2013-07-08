#!/bin/sh -e
# libcurl-7.31.0 by KaKaRoTo
# modified by mhaqs for 7.31.0 release and cpp compatibility

## Download the source code.
wget --continue http://curl.haxx.se/download/curl-7.31.0.tar.gz

## Unpack the source code.
rm -Rf curl-7.31.0 && tar xfvz curl-7.31.0.tar.gz && cd curl-7.31.0

## Patch the source code.
cat ../../patches/libcurl-7.31.0.patch | patch -p1

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
          --includedir="$PS3DEV/portlibs/ppu/include"   --libdir="$PS3DEV/portlibs/ppu/lib" --without-ssl --with-polarssl="$PS3DEV/portlibs/ppu/include/polarssl" --with-ca-bundle="/usr/ssl/certs/ca-bundle.crt"

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
