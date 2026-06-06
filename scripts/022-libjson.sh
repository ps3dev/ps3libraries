#!/bin/sh -e
# libjson-c.sh by Mohammad Haseeb (mmhaqs@gmail.com)

wget --no-check-certificate https://codeload.github.com/json-c/json-c/tar.gz/json-c-0.11-20130402 -O jsonc.tar.gz

## Download an up-to-date config.guess and config.sub
if [ ! -f config.guess ]; then wget --continue http://git.savannah.gnu.org/cgit/config.git/plain/config.guess; fi
if [ ! -f config.sub ]; then wget --continue http://git.savannah.gnu.org/cgit/config.git/plain/config.sub; fi

## Unpack the source code.
rm -Rf jsonc && mkdir jsonc && tar --strip-components=1 --directory=jsonc -xvzf jsonc.tar.gz

## Create the build directory.
cd jsonc

## Replace config.guess and config.sub
cp ../config.guess ../config.sub .

## Configure the build.
CFLAGS="-Wno-error -I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
AR="powerpc64-ps3-elf-ar" CC="powerpc64-ps3-elf-gcc" RANLIB="powerpc64-ps3-elf-ranlib" \
ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes \
./configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --enable-static --disable-shared

## Compile and install.
${MAKE:-make} && ${MAKE:-make} install
