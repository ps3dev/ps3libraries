#!/bin/sh -e
# sdl_psl1ght.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
../download.sh submodules/SDL_PSL1GHT

## Unpack the source code.
rm -Rf sdl_psl1ght && mkdir sdl_psl1ght && git --git-dir=../submodules/SDL_PSL1GHT/.git --work-tree=sdl_psl1ght checkout-index -a

## Create the build directory.
cd sdl_psl1ght

## Compile and install.
./script.sh && ${MAKE:-make} && ${MAKE:-make} install
