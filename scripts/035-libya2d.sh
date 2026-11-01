#!/usr/bin/env bash
set -eo pipefail
# ya2d_ps3 by xerpi
#	fork by Bucanero

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ya2d.tar.gz

## Unpack the source code.
rm -Rf ya2d
mkdir ya2d
echo "Unpacking ya2d"
extract ../archives/ya2d.tar.gz --strip-components=1 --directory=ya2d
cd ya2d/libya2d

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" install
