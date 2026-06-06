#!/bin/sh -e
#
# unRAR library ported to PS3 by Bucanero

## Download the source code.
../download.sh libunrar.tar.gz 

## Unpack the source code.
rm -Rf libunrar && mkdir libunrar && tar --strip-components=1 --directory=libunrar -xvzf ../archives/libunrar.tar.gz && cd libunrar

## Compile and install.
${MAKE:-make} install
