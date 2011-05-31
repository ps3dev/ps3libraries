#!/bin/sh
# freetype-2.4.3.sh by Dan Peori (danpeori@oopo.net)

## Download the source code.
wget --continue http://voxel.dl.sourceforge.net/project/freetype/freetype2/2.4.3/freetype-2.4.3.tar.gz || { exit 1; }

## Unpack the source code.
rm -Rf freetype-2.4.3 && tar xfvz freetype-2.4.3.tar.gz && cd freetype-2.4.3 || { exit 1; }

## Create the build directory.
mkdir build-ppu && cd build-ppu || { exit 1; }

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
GNUMAKE=${MAKE:-make} ../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared || { exit 1; }

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install || { exit 1; }
