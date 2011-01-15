#!/bin/sh
# libzip-0.9.3.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://www.nih.at/libzip/libzip-0.9.3.tar.bz2 || { exit; }

## Unpack the source code.
rm -Rf libzip-0.9.3 && tar xfvj libzip-0.9.3.tar.bz2 && cd libzip-0.9.3 || { exit 1; }

## Patch the source code.
cat ../../patches/libzip-0.9.3-PPU.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
CFLAGS="-I$PS3DEV/host/ppu/include" \
LDFLAGS="-L$PS3DEV/host/ppu/lib -L$PSL1GHT/lib" \
PKG_CONFIG_PATH="$PS3DEV/host/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/host/ppu" --host="ppu" --disable-shared || { exit 1; }

## Compile and install.
make -j4 && make install || { exit 1; }
