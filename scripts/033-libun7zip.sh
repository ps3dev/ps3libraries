#!/usr/bin/env bash
set -eo pipefail
# un7Zip library by Bucanero

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh libun7zip.tar.gz

## Unpack the source code.
rm -Rf libun7zip
mkdir libun7zip
echo "Unpacking libun7zip"
extract ../archives/libun7zip.tar.gz --strip-components=1 --directory=libun7zip
cd libun7zip

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" install
