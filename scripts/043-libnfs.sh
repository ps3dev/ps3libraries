#!/usr/bin/env bash
set -eo pipefail
# libnfs by sahlberg
#	ported to PS3 by Bucanero

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh libnfs.tar.gz 

## Unpack the source code.
rm -Rf libnfs
mkdir libnfs
echo "Unpacking libnfs"
extract ../archives/libnfs.tar.gz --strip-components=1 --directory=libnfs
cd libnfs

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" -f ps3_ppu/Makefile.PS3_PPU install
