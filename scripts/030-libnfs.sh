#!/bin/sh -e
#
# libnfs by sahlberg
#	ported to PS3 by Bucanero

## Download the source code.
../download.sh submodules/libnfs

## Unpack the source code.
rm -Rf libnfs && mkdir libnfs && git --git-dir=../submodules/libnfs/.git --work-tree=libnfs checkout-index -a && cd libnfs

## Compile and install.
${MAKE:-make} -f ps3_ppu/Makefile.PS3_PPU install
