#!/bin/sh -e
# pixman-0.20.0.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
wget http://cairographics.org/releases/pixman-0.20.0.tar.gz

## Download an up-to-date config.guess and config.sub
if [ ! -f config.guess ]; then wget http://git.savannah.gnu.org/cgit/config.git/plain/config.guess; fi
if [ ! -f config.sub ]; then wget http://git.savannah.gnu.org/cgit/config.git/plain/config.sub; fi

## Unpack the source code.
rm -Rf pixman-0.20.0 && tar xfvz pixman-0.20.0.tar.gz && cd pixman-0.20.0

## Replace config.guess and config.sub
cp ../config.guess ../config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include -DPIXMAN_NO_TLS" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared --disable-vmx

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
