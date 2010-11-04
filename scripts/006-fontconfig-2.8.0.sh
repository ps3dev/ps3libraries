#!/bin/sh
# fontconfig-2.8.0.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://www.fontconfig.org/release/fontconfig-2.8.0.tar.gz || { exit 1; }

## Unpack the source code.
rm -Rf fontconfig-2.8.0 && tar xfvz fontconfig-2.8.0.tar.gz && cd fontconfig-2.8.0 || { exit 1; }

## Patch the source code.
cat ../../patches/fontconfig-2.8.0-PPU.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
CFLAGS="-O2 -Wall -L$PS3DEV/ppu/lib" CPPFLAGS="-I$PS3DEV/ppu/include" PKG_CONFIG_PATH="$PS3DEV/ppu/lib/pkgconfig" ../configure --prefix="$PS3DEV/ppu" --host="ppu" --disable-shared --with-arch="powerpc64-unknown-elf" || { exit 1; }

## Compile and install.
make -j4 && make install || { exit 1; }
