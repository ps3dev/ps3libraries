#!/bin/sh -e
#
# libsmb2 by sahlberg
#	ported to PS3 by Bucanero

## Download the source code.
../download.sh submodules/libsmb2

## Unpack the source code.
rm -Rf libsmb2 && mkdir libsmb2 && git --git-dir=../submodules/libsmb2/.git --work-tree=libsmb2 checkout-index -a && cd libsmb2/lib

## Compile and install.
${MAKE:-make} -f Makefile.PS3_PPU install
