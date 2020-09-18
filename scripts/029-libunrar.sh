#!/bin/sh -e
#
# unRAR library ported to PS3 by Bucanero

## Download the source code.
wget --no-check-certificate https://github.com/bucanero/libunrar-ps3/tarball/master -O libunrar.tar.gz 

## Unpack the source code.
rm -Rf libunrar && mkdir libunrar && tar --strip-components=1 --directory=libunrar -xvzf libunrar.tar.gz && cd libunrar

## Compile and install.
${MAKE:-make} install
