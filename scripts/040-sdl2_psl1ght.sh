#!/bin/sh -e
# sdl2_psl1ght.sh by Humberto Dias

## Download the source code.
# SDL2
wget https://github.com/humbertodias/SDL2_PSL1GHT/tarball/master -O sdl2_psl1ght.tar.gz

## Unpack the source code.
rm -Rf sdl2_psl1ght && mkdir sdl2_psl1ght && tar --strip-components=1 --directory=sdl2_psl1ght -xvzf sdl2_psl1ght.tar.gz

## Create the build directory.
cd sdl2_psl1ght

## Compile and install.
./script.sh && ${MAKE:-make} && ${MAKE:-make} install
