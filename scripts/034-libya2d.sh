#!/bin/sh -e
# ya2d_ps3 by xerpi
#	fork by Bucanero

## Download the source code.
wget https://github.com/bucanero/ya2d_ps3/tarball/master -O ya2d.tar.gz 

## Unpack the source code.
rm -Rf ya2d && mkdir ya2d && tar --strip-components=1 --directory=ya2d -xvzf ya2d.tar.gz && cd ya2d/libya2d

## Compile and install.
${MAKE:-make} install
