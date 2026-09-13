#!/usr/bin/env bash
set -eo pipefail
# debugnet.sh by Sergio Padrino (@sergiou87)

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ps3debugnet.tar.gz

## Unpack the source code.
rm -Rf ps3debugnet
mkdir ps3debugnet
echo "Unpacking ps3debugnet"
extract ../archives/ps3debugnet.tar.gz --strip-components=1 --directory=ps3debugnet
cd ps3debugnet/libdebugnet

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" && ${MAKE:-make} -j"$jobs" install
