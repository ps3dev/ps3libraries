#!/usr/bin/env bash
set -eo pipefail
# libsmb2 by sahlberg
#	ported to PS3 by Bucanero
SMB2="libsmb2"

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ${SMB2}.tar.gz 

## Unpack the source code.
rm -Rf ${SMB2}
mkdir ${SMB2}
echo "Unpacking ${SMB2}"
extract ../archives/${SMB2}.tar.gz --strip-components=1 --directory=${SMB2}
cd ${SMB2}/lib

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" -f Makefile.PS3_PPU install
