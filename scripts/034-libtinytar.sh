#!/usr/bin/env bash
set -eo pipefail
# tar/tar.gz/tar.bz2 library by Bucanero

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh libtinytar.tar.gz

## Unpack the source code.
rm -Rf libtinytar
mkdir libtinytar
echo "Unpacking libtinytar"
extract ../archives/libtinytar.tar.gz --strip-components=1 --directory=libtinytar
cd libtinytar

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" install
