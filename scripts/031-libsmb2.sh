#!/bin/sh -e
#
# libsmb2 by sahlberg
#	ported to PS3 by Bucanero

## Download the source code.
wget --no-check-certificate https://github.com/sahlberg/libsmb2/tarball/master -O tiny3d.tar.gz 

## Unpack the source code.
rm -Rf libsmb2 && mkdir libsmb2 && tar --strip-components=1 --directory=libsmb2 -xvzf libsmb2.tar.gz && cd libsmb2/lib

## Compile and install.
${MAKE:-make} -f Makefile.PS3_PPU install
