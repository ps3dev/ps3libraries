#!/bin/sh -e
# libvorbis-1.3.2.sh by Naomi Peori (naomi@peori.ca)

## Unpack the source code.
rm -Rf libvorbis-1.3.2
echo "Unpacking libvorbis-1.3.2"
pv -pterab ../downloads/libvorbis-1.3.2.tar.gz | tar xzf -
cd libvorbis-1.3.2

## Replace config.guess and config.sub
cp "$(automake --print-libdir)"/config.guess "$(automake --print-libdir)"/config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
