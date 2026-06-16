#!/usr/bin/env bash
set -eo pipefail

# sdl_psl1ght_libs.sh by Naomi Peori (naomi@peori.ca)

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh sdl_psl1ght_libs.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf sdl_psl1ght_libs
mkdir sdl_psl1ght_libs
echo "Unpacking sdl_psl1ght_libs"
extract ../archives/sdl_psl1ght_libs.tar.gz --strip-components=1 --directory=sdl_psl1ght_libs
cd sdl_psl1ght_libs

## Preload config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub archives/

## Compile and install.
./make_SDL_Libs.sh
