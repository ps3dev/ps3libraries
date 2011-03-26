#!/bin/sh
# libpng-1.4.4.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://download.sourceforge.net/libpng/libpng-1.4.4.tar.gz || { exit 1; }

## Unpack the source code.
rm -Rf libpng-1.4.4 && tar xfvz libpng-1.4.4.tar.gz && cd libpng-1.4.4 || { exit 1; }

## Patch the source code.
cat ../../patches/libpng-1.4.4-PPU.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
CFLAGS="-I$PS3DEV/host/ppu/include" \
LDFLAGS="-L$PS3DEV/host/ppu/lib -L$PSL1GHT/lib" \
PKG_CONFIG_PATH="$PS3DEV/host/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/host/ppu" --host="ppu" --enable-static --disable-shared || { exit 1; }

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install || { exit 1; }
