#!/usr/bin/env bash
set -eo pipefail
# pthread-emb ps3 library

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh pthread-emb-ps3.tar.gz

## Unpack the source code.
rm -Rf pthread-emb-ps3
mkdir pthread-emb-ps3
echo "Unpacking pthread-emb"
extract ../archives/pthread-emb-ps3.tar.gz --strip-components=1 --directory=pthread-emb-ps3
cd pthread-emb-ps3/platform/psl1ght

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" install
