#!/bin/sh -e
# sdl2_psl1ght.sh by Humberto Dias

## Download the source code.
# SDL2
#wget https://github.com/humbertodias/SDL2_PSL1GHT/tarball/master -O sdl2_psl1ght.tar.gz
#wget https://github.com/humbertodias/psl1ght-2.0.3/tarball/psl1ght-2.0.3 -O sdl2_psl1ght.tar.gz
wget https://github.com/humbertodias/sdl2_psl1ght_/tarball/psl1ght-2.30.1 -O sdl2_psl1ght.tar.gz

## Unpack the source code.
rm -Rf sdl2_psl1ght && mkdir sdl2_psl1ght && tar --strip-components=1 --directory=sdl2_psl1ght -xvzf sdl2_psl1ght.tar.gz

## Create the build directory.
cd sdl2_psl1ght

## Compile and install.
./script.sh && ${MAKE:-make} && ${MAKE:-make} install

# Copy sdl2-config to PATH
cp sdl2-config $PS3DEV/portlibs/ppu/bin
