#!/bin/sh -e
# sdl_psl1ght.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
../download.sh sdl2_psl1ght.tar.gz

## Unpack the source code.
rm -Rf sdl2_psl1ght && mkdir sdl2_psl1ght && tar --strip-components=1 --directory=sdl2_psl1ght -xvzf ../archives/sdl2_psl1ght.tar.gz

## Create the build directory.
cd sdl2_psl1ght

## Compile and install.
./script.sh && ${MAKE:-make} -j4 && ${MAKE:-make} install
