#!/bin/sh
# libvorbis-1.3.2.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.2.tar.gz || { exit 1; }

## Unpack the source code.
rm -Rf libvorbis-1.3.2 && tar xfvz libvorbis-1.3.2.tar.gz && cd libvorbis-1.3.2 || { exit 1; }

## Patch the source code.
cat ../../patches/libvorbis-1.3.2-PPU.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="ppu" --disable-shared || { exit 1; }

## Compile and install.
make -j4 && make install || { exit 1; }
