#!/usr/bin/env bash
set -eo pipefail

# psl1ght.sh by Naomi Peori (naomi@peori.ca)

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh psl1ght.tar.gz

## Unpack the source code.
rm -Rf psl1ght
mkdir psl1ght
echo "Unpacking psl1ght"
extract ../archives/psl1ght.tar.gz --strip-components=1 --directory=psl1ght
cd psl1ght

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" install-ctrl && ${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
