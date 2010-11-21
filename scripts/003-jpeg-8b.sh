#!/bin/sh
# jpeg-8b.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://www.ijg.org/files/jpegsrc.v8b.tar.gz || { exit 1; }

## Unpack the source code.
rm -Rf jpeg-8b && tar xfvz jpegsrc.v8b.tar.gz && cd jpeg-8b || { exit 1; }

## Patch the source code.
cat ../../patches/jpeg-8b-PPU.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
CFLAGS="-I$PS3DEV/ppu/include" \
LDFLAGS="-L$PS3DEV/ppu/lib -L$PSL1GHT/lib -T$PSL1GHT/lib/linker.x -nostartfiles $PSL1GHT/lib/crt1.o $PS3DEV/ppu/ppu/lib/crti.o" \
PKG_CONFIG_PATH="$PS3DEV/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/ppu" --host="ppu" --disable-shared || { exit 1; }

## Compile and install.
make -j4 && make install || { exit 1; }
