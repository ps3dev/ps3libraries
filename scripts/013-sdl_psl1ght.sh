#!/usr/bin/env bash
set -eo pipefail

# sdl_psl1ght.sh by Naomi Peori (naomi@peori.ca)

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh sdl_psl1ght.tar.gz

## Unpack the source code.
rm -Rf sdl_psl1ght
mkdir sdl_psl1ght
echo "Unpacking sdl_psl1ght"
extract ../archives/sdl_psl1ght.tar.gz --strip-components=1 --directory=sdl_psl1ght
cd sdl_psl1ght

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
./script.sh && ${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
