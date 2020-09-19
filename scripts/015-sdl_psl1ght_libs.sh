#!/bin/sh -e
# sdl_psl1ght_libs.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
../download.sh submodules/SDL_PSL1GHT_Libs

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../scripts/get-config-scripts.sh

## Unpack the source code.
rm -Rf sdl_psl1ght_libs && mkdir sdl_psl1ght_libs && git --git-dir=../submodules/SDL_PSL1GHT_Libs/.git --work-tree=sdl_psl1ght_libs checkout-index -a

## Use any already downloaded archives from submodules dir
for i in ../submodules/SDL_PSL1GHT_Libs/archives/*; do
  case "$i" in
    */archives.txt) ;;
    *) [ -f "$i" ] && ln "$i" sdl_psl1ght_libs/archives/ ;;
  esac
done

## Create the build directory.
cd sdl_psl1ght_libs

## Preload config.guess and config.sub
rm -f archives/config.guess archives/config.sub
cp ../../archives/config.guess ../../archives/config.sub archives/

## Compile and install.
./make_SDL_Libs.sh
