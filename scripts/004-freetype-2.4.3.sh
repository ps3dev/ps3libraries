#!/bin/sh -e
# freetype-2.4.3.sh by Naomi Peori (naomi@peori.ca)

## Unpack the source code.
rm -Rf freetype-2.4.3
echo "Unpacking freetype-2.4.3"
pv -pterab ../downloads/freetype-2.4.3.tar.gz | tar xzf -
cd freetype-2.4.3

## Replace config.guess and config.sub
cp "$(automake --print-libdir)"/config.guess "$(automake --print-libdir)"/config.sub builds/unix/

## Create the build directory.
mkdir build-ppu && cd build-ppu

## freetype insists on GNU make
which gmake 1>/dev/null 2>&1 && MAKE=gmake

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
GNUMAKE=$MAKE ../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
