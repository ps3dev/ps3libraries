#!/bin/sh -e
# tiff-3.9.4.sh by Jon Limle <jonlimle123@yahoo.com>

## Unpack the source code.
rm -Rf tiff-3.9.4
echo "Unpacking tiff-3.9.4.tar.gz"
pv -pterab ../downloads/tiff-3.9.4.tar.gz | tar xzf -
cd tiff-3.9.4

## Replace config.guess and config.sub
cp "$(automake --print-libdir)"/config.guess "$(automake --print-libdir)"/config.sub config/

## Patch the source code.
cat ../../patches/tiff-3.9.4-PPU.patch | patch -p1

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} && ${MAKE:-make} install
