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
wget --no-check-certificate https://github.com/wargio/tiny3d/tarball/master -O tiny3d.tar.gz 

## Unpack the source code.
rm -Rf tiny3d && mkdir tiny3d && tar --strip-components=1 --directory=tiny3d -xvzf tiny3d.tar.gz && cd tiny3d

## Compile and install.
${MAKE:-make} install -C lib --no-print-directory
${MAKE:-make} install -C libfont --no-print-directory
