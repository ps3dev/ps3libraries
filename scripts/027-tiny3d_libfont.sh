#!/bin/sh -e
# tini3d_libfont.sh by CrystalCT (crystal@unict.it)
# Tiny3D 2.0 + libfont Credits: 
#	Hermes         - Author
#	ElSemi         - Vertex Program Compiler and other useful sample code
#	HACKERCHANNEL  - PSL1GHT
#	Oopo           - ps3libraries
#	xerpi          - porting the lib to v2
#	deroad/Wargio  - check code
#	Bucanero, CrystalCT, Miigotu, Shagkur, Wargio and Zeldin to update Tiny3D for GCC 7.2.0

## Download the source code.
../download.sh submodules/tiny3d

## Unpack the source code.
rm -Rf tiny3d && mkdir tiny3d && git --git-dir=../submodules/tiny3d/.git --work-tree=tiny3d checkout-index -a && cd tiny3d

## Compile and install.
${MAKE:-make} install -C lib --no-print-directory
${MAKE:-make} install -C libfont --no-print-directory
