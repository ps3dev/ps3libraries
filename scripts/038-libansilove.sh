#!/bin/sh -e
# libansilove by Stefan Vogt, Brian Cassidy, and Frederic Cambus
#   ported to PS3 by Bucanero

## Download the source code.
wget https://github.com/bucanero/libansilove/tarball/master -O libansilove.tar.gz 

## Unpack the source code.
rm -Rf libansilove && mkdir libansilove && tar --strip-components=1 --directory=libansilove -xvzf libansilove.tar.gz && cd libansilove

## Compile and install.
${MAKE:-make} install
