#!/usr/bin/env bash
set -eo pipefail
# mini18n by Yabause team
#   ported to PS3 by Bucanero

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh mini18n.tar.gz

## Unpack the source code.
rm -Rf mini18n
mkdir mini18n
echo "Unpacking mini18n"
extract ../archives/mini18n.tar.gz --strip-components=1 --directory=mini18n
cd mini18n

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" install
