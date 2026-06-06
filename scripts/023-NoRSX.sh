#!/bin/sh -e
# libNoRSX.sh by wargio (wargio@libero.it)

## Download the source code.
wget --no-check-certificate https://github.com/wargio/NoRSX/tarball/master -O NoRSX.tar.gz 

## Unpack the source code.
rm -Rf NoRSX && mkdir NoRSX && tar --strip-components=1 --directory=NoRSX -xvzf NoRSX.tar.gz && cd NoRSX

## Compile and install.
${MAKE:-make}
