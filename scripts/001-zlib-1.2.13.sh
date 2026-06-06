#!/bin/sh -e
# zlib-1.2.13.sh by Naomi Peori (naomi@peori.ca)
ZLIB="zlib-1.2.13"

## Unpack the source code.
rm -Rf ${ZLIB}
echo "Unpacking %{ZLIB}"
pv -pterab ../downloads/${ZLIB}.tar.gz | tar xzf -
cd ${ZLIB}

## Patch the source code.
cat ../../patches/${ZLIB}-PPU.patch | patch -p1

## Configure the build.
AR="powerpc64-ps3-elf-ar" CC="powerpc64-ps3-elf-gcc" RANLIB="powerpc64-ps3-elf-ranlib" \
./configure --prefix="$PS3DEV/portlibs/ppu" --static

## Compile and install.
${MAKE:-make} -j4 AR="powerpc64-ps3-elf-ar" ARFLAGS="rc" RANLIB="powerpc64-ps3-elf-ranlib"
${MAKE:-make} install AR="powerpc64-ps3-elf-ar" ARFLAGS="rc" RANLIB="powerpc64-ps3-elf-ranlib"