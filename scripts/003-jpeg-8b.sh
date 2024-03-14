#!/bin/sh -e
# jpeg-8b.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
wget http://www.ijg.org/files/jpegsrc.v8b.tar.gz

## Download an up-to-date config.guess and config.sub
if [ ! -f config.guess ]; then wget http://git.savannah.gnu.org/cgit/config.git/plain/config.guess; fi
if [ ! -f config.sub ]; then wget http://git.savannah.gnu.org/cgit/config.git/plain/config.sub; fi

## Unpack the source code.
rm -Rf jpeg-8b && tar xfvz jpegsrc.v8b.tar.gz && cd jpeg-8b

## Replace config.guess and config.sub
cp ../config.guess ../config.sub .

## Patch the source code.
cat ../../patches/jpeg-8b-PPU.patch | patch -p1

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install

