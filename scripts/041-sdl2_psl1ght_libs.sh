#!/bin/sh -e
# sdl2_psl1ght_libs.sh by Humberto Dias

## Download the source code.
# SDL2
wget https://github.com/humbertodias/SDL2_PSL1GHT_Libs/tarball/master -O sdl2_psl1ght_libs.tar.gz

## Unpack the source code.
rm -Rf sdl2_psl1ght_libs && mkdir sdl2_psl1ght_libs && tar --strip-components=1 --directory=sdl2_psl1ght_libs -xvzf sdl2_psl1ght_libs.tar.gz

## Create the build directory.
cd sdl2_psl1ght_libs

## Compile and install.
./make_SDL_Libs.sh
