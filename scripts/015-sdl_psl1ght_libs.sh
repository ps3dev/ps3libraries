#!/bin/sh -e
# sdl_psl1ght_libs.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
../download.sh submodules/SDL_PSL1GHT_Libs

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../scripts/get-config-scripts.sh

## Unpack the source code.
rm -Rf sdl_psl1ght_libs && mkdir sdl_psl1ght_libs && git --git-dir=../submodules/SDL_PSL1GHT_Libs/.git --work-tree=sdl_psl1ght_libs checkout-index -a

## Create the build directory.
cd sdl_psl1ght_libs

## Preload config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub archives/

## Compile and install.
./make_SDL_Libs.sh
