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
CFLAGS="-I$PS3DEV/host/ppu/include -DCAIRO_NO_MUTEX" \
LDFLAGS="-L$PS3DEV/host/ppu/lib -L$PSL1GHT/lib" \
PKG_CONFIG_PATH="$PS3DEV/host/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/host/ppu" --host="ppu" --enable-fc="no" --enable-xlib="no" --disable-shared --disable-valgrind --enable-gobject="no" || { exit 1; }

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install || { exit 1; }
