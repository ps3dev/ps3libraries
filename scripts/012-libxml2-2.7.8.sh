#!/bin/sh -e
# libxml2-2.7.8.sh by Naomi Peori (naomi@peori.ca)

## Unpack the source code.
rm -Rf libxml2-2.7.8
mkdir libxml2-2.7.8
echo "Unpacking libxml2-2.7.8"
pv -pterb ../downloads/libxml2-2.7.8.tar.gz | tar --strip-components=1 -xzf -
cd libxml2-2.7.8

## Replace config.guess and config.sub
cp "$(automake --print-libdir)"/config.guess "$(automake --print-libdir)"/config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --enable-static --disable-shared --without-ftp --without-http --without-python

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
