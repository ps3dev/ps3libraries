#!/bin/sh -e
#
# tar/tar.gz/tar.bz2 library by Bucanero

## Download the source code.
wget https://github.com/bucanero/libtinytar/tarball/master -O libtinytar.tar.gz 

## Unpack the source code.
rm -Rf libtinytar && mkdir libtinytar && tar --strip-components=1 --directory=libtinytar -xvzf libtinytar.tar.gz && cd libtinytar

## Compile and install.
${MAKE:-make} install
