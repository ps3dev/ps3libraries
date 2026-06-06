#!/bin/sh -e
# libNoRSX.sh by wargio (wargio@libero.it)

## Download the source code.
../download.sh NoRSX.tar.gz 

## Unpack the source code.
rm -Rf NoRSX && mkdir NoRSX && tar --strip-components=1 --directory=NoRSX -xvzf ../archives/NoRSX.tar.gz && cd NoRSX

## Compile and install.
${MAKE:-make}
