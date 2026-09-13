#!/usr/bin/env bash
set -eo pipefail
# libNoRSX.sh by wargio (wargio@libero.it)

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh NoRSX.tar.gz 

## Unpack the source code.
rm -Rf NoRSX
mkdir NoRSX
echo "Unpacking NoRSX"
extract ../archives/NoRSX.tar.gz --strip-components=1 --directory=NoRSX
cd NoRSX

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs"
