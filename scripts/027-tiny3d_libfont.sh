#!/usr/bin/env bash
set -eo pipefail
# tini3d_libfont.sh by CrystalCT (crystal@unict.it)
# Tiny3D 2.0 + libfont Credits: 
#	Hermes         - Author
#	ElSemi         - Vertex Program Compiler and other useful sample code
#	HACKERCHANNEL  - PSL1GHT
#	Oopo           - ps3libraries
#	xerpi          - porting the lib to v2
#	deroad/Wargio  - check code
#	Bucanero, CrystalCT, Miigotu, Shagkur, Wargio and Zeldin to update Tiny3D for GCC 7.2.0

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh tiny3d.tar.gz 

## Unpack the source code.
rm -Rf tiny3d
mkdir tiny3d
echo "Unpacking tiny3d"
extract ../archives/tiny3d.tar.gz --strip-components=1 --directory=tiny3d
cd tiny3d

## Compile and install.
${MAKE:-make} -j"$jobs" install -C lib --no-print-directory
${MAKE:-make} -j"$jobs" install -C libfont --no-print-directory
