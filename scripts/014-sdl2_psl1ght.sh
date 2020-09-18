#!/bin/sh -e
# sdl_psl1ght.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
../download.sh submodules/SDL2_PSL1GHT

## Unpack the source code.
rm -Rf sdl2_psl1ght && mkdir sdl2_psl1ght && git --git-dir=../submodules/SDL2_PSL1GHT/.git --work-tree=sdl2_psl1ght checkout-index -a

## Create the build directory.
cd sdl2_psl1ght

## Compile and install.
./script.sh && ${MAKE:-make} -j4 && ${MAKE:-make} install
