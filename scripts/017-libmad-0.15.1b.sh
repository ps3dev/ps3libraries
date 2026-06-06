#!/bin/sh -e
# libmad-0.15.1b.sh by dhewg (dhewg@wiibrew.org)

## Unpack the source code.
rm -Rf libmad-0.15.1b
echo "Unpacking libmad-0.15.1b"
pv -pterab ../downloads/libmad-0.15.1b.tar.gz | tar xzf -
cd libmad-0.15.1b

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
