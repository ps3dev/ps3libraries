#!/bin/sh -e
# libcurl-7.31.0 by KaKaRoTo
# modified by mhaqs for 7.31.0 release and cpp compatibility

VERSION=7.64.1
## Download the source code.
wget http://curl.haxx.se/download/curl-${VERSION}.tar.gz

## Download an up-to-date config.guess and config.sub
if [ ! -f config.guess ]; then wget http://git.savannah.gnu.org/cgit/config.git/plain/config.guess; fi
if [ ! -f config.sub ]; then wget http://git.savannah.gnu.org/cgit/config.git/plain/config.sub; fi

## Unpack the source code.
rm -Rf curl-${VERSION} && tar xfvz curl-${VERSION}.tar.gz && cd curl-${VERSION}

## Replace config.guess and config.sub
cp ../config.guess ../config.sub .

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
${MAKE:-make} -j4 && ${MAKE:-make} install
