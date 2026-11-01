#!/usr/bin/env bash
set -eo pipefail
# libansilove by Stefan Vogt, Brian Cassidy, and Frederic Cambus
#   ported to PS3 by Bucanero

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh libansilove.tar.gz

## Unpack the source code.
rm -Rf libansilove
mkdir libansilove
echo "Unpacking libansilove"
extract ../archives/libansilove.tar.gz --strip-components=1 --directory=libansilove
cd libansilove

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" install
