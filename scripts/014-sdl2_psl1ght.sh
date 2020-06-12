#!/bin/sh -e
# sdl_psl1ght.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
wget --no-check-certificate https://github.com/sergiou87/SDL2_PSL1GHT/tarball/master -O sdl2_psl1ght.tar.gz

## Unpack the source code.
rm -Rf sdl2_psl1ght && mkdir sdl2_psl1ght && tar --strip-components=1 --directory=sdl2_psl1ght -xvzf sdl2_psl1ght.tar.gz

## Create the build directory.
cd sdl2_psl1ght

## Compile and install.
./script.sh && ${MAKE:-make} -j4 && ${MAKE:-make} install
