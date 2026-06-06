#!/bin/sh -e
# libzip-0.9.3.sh by Naomi Peori (naomi@peori.ca)

## Unpack the source code.
rm -Rf libzip-0.9.3
echo "Unpacking libzip-0.9.3.tar"
pv -pterab ../downloads/libzip-0.9.3.tar.tar.bz2 | tar xjf -
cd libzip-0.9.3

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
