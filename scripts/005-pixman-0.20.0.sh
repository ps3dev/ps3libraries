#!/bin/sh -e
# pixman-0.20.0.sh by Naomi Peori (naomi@peori.ca)

## Unpack the source code.
rm -Rf pixman-0.20.0
echo "Unpacking pixman-0.20.0"
pv -pterab ../downloads/pixman-0.20.0.tar.gz | tar xzf -
cd pixman-0.20.0

## Replace config.guess and config.sub
cp "$(automake --print-libdir)"/config.guess "$(automake --print-libdir)"/config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include -DPIXMAN_NO_TLS" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared --disable-vmx

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
