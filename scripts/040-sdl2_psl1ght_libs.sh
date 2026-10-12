#!/usr/bin/env bash
set -eo pipefail

# sdl2_psl1ght_libs.sh by Humberto Dias

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh sdl2_psl1ght_libs.tar.gz

## Fetch config.guess and config.sub, falling back to copies if Savannah is unavailable
../config/get-config-scripts.sh

## Unpack the source code.
rm -Rf sdl2_psl1ght_libs
mkdir sdl2_psl1ght_libs
echo "Unpacking sdl2_psl1ght_libs"
extract ../archives/sdl2_psl1ght_libs.tar.gz --strip-components=1 --directory=sdl2_psl1ght_libs
cd sdl2_psl1ght_libs

## Preload config.guess and config.sub
cp ../../archives/config.guess ../../archives/config.sub archives/

## Host Homebrew .pc files must not leak into PPU configure/link.
export PKG_CONFIG_LIBDIR="${PS3DEV}/portlibs/ppu/lib/pkgconfig"
export PKG_CONFIG_PATH="${PS3DEV}/portlibs/ppu/lib/pkgconfig"

## Compile and install.
./make_SDL_Libs.sh
