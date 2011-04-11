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
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include -DPIXMAN_NO_TLS" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="ppu" --disable-shared --disable-vmx || { exit 1; }

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install || { exit 1; }
