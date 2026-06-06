#!/bin/sh -e
# sdl_psl1ght_libs.sh by Naomi Peori (naomi@peori.ca)

## Unpack the source code.
rm -Rf sdl_psl1ght_libs
mkdir sdl_psl1ght_libs
pv -pterb ../downloads/sdl_psl1ght_libs.tar.gz | tar --strip-components=1 --directory=sdl_psl1ght_libs -xzf -
cd sdl_psl1ght_libs

## Compile and install.
./make_SDL_Libs.sh
