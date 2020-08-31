#!/bin/sh -e
#
# libnfs by sahlberg
#	ported to PS3 by Bucanero

## Download the source code.
wget --no-check-certificate https://github.com/sahlberg/libnfs/tarball/master -O tiny3d.tar.gz 

## Unpack the source code.
rm -Rf libnfs && mkdir libnfs && tar --strip-components=1 --directory=libnfs -xvzf libnfs.tar.gz && cd libnfs

## Compile and install.
${MAKE:-make} -f ps3_ppu/Makefile.PS3_PPU install
