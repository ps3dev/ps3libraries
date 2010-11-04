#!/bin/sh
# cairo-1.10.0.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://cairographics.org/releases/cairo-1.10.0.tar.gz || { exit 1; }

## Unpack the source code.
rm -Rf cairo-1.10.0 && tar xfvz cairo-1.10.0.tar.gz && cd cairo-1.10.0 || { exit 1; }

## Patch the source code.
cat ../../patches/cairo-1.10.0-PPU.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
CFLAGS="-O2 -Wall -L$PS3DEV/ppu/lib -DCAIRO_NO_MUTEX" CPPFLAGS="-I$PS3DEV/ppu/include" PKG_CONFIG_PATH="$PS3DEV/ppu/lib/pkgconfig" ../configure --prefix="$PS3DEV/ppu" --host="ppu" --enable-fc="no" --enable-xlib="no" --disable-shared --disable-valgrind --enable-gobject="no" || { exit 1; }

## Compile and install.
make -j4 && make install || { exit 1; }
