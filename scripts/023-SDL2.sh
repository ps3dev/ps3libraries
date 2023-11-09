#!/bin/sh -e
# sdl2.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
wget --no-check-certificate https://github.com/StrawFox64/SDL2PSL1GHT/tarball/master -O SDL2PSL1GHT.tar.gz

## Create the build directory.
rm -Rf SDL2PSL1GHT && mkdir SDL2PSL1GHT

## Unpack the source code.
tar --strip-components=1 --directory=SDL2PSL1GHT -xvzf SDL2PSL1GHT.tar.gz

## Open Directory
cd SDL2PSL1GHT

## Compile and install.
./script.sh && ${MAKE:-make} && ${MAKE:-make} install
