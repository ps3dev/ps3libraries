#!/bin/sh
# pixman-0.20.0.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://cairographics.org/releases/pixman-0.20.0.tar.gz || { exit 1; }

## Unpack the source code.
rm -Rf pixman-0.20.0 && tar xfvz pixman-0.20.0.tar.gz && cd pixman-0.20.0 || { exit 1; }

## Patch the source code.
cat ../../patches/pixman-0.20.0-PPU.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
CFLAGS="-I$PS3DEV/host/ppu/include -DPIXMAN_NO_TLS" \
LDFLAGS="-L$PS3DEV/host/ppu/lib -L$PSL1GHT/lib" \
PKG_CONFIG_PATH="$PS3DEV/host/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/host/ppu" --host="ppu" --disable-shared --disable-vmx || { exit 1; }

## Compile and install.
make -j4 && make install || { exit 1; }
