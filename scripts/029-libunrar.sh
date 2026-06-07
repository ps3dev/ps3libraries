#!/bin/sh -e
#
# unRAR library ported to PS3 by Bucanero

## Download the source code.
../download.sh submodules/libunrar-ps3

## Unpack the source code.
rm -Rf libunrar && mkdir libunrar && git --git-dir=../submodules/libunrar-ps3/.git --work-tree=libunrar checkout-index -a && cd libunrar

## Compile and install.
${MAKE:-make} install
