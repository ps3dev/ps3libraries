#!/bin/sh
# freetype-2.4.3.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://download.savannah.gnu.org/releases/freetype/freetype-2.4.3.tar.bz2 || { exit 1; }

## Unpack the source code.
rm -Rf freetype-2.4.3 && tar xfvj freetype-2.4.3.tar.bz2 && cd freetype-2.4.3 || { exit 1; }

## Patch the source code.
cat ../../patches/freetype-2.4.3-PPU.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
CFLAGS="-I$PS3DEV/ppu/include" \
LDFLAGS="-L$PS3DEV/ppu/lib -L$PSL1GHT/lib -T$PSL1GHT/lib/linker.x -nostartfiles $PSL1GHT/lib/crt1.o $PS3DEV/ppu/ppu/lib/crti.o" \
PKG_CONFIG_PATH="$PS3DEV/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/ppu" --host="ppu" --disable-shared || { exit 1; }

## Compile and install.
make -j4 && make install || { exit 1; }
