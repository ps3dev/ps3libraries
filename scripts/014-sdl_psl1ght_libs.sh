#!/bin/sh -e
# sdl_psl1ght_libs.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
wget --no-check-certificate https://github.com/zeldin/SDL_PSL1GHT_Libs/tarball/master -O sdl_psl1ght_libs.tar.gz

## Unpack the source code.
rm -Rf sdl_psl1ght_libs && mkdir sdl_psl1ght_libs && tar --strip-components=1 --directory=sdl_psl1ght_libs -xvzf sdl_psl1ght_libs.tar.gz

## Create the build directory.
cd sdl_psl1ght_libs

## Compile and install.
./make_SDL_Libs.sh
