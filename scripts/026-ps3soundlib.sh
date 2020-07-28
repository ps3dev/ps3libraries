#!/bin/sh -e
# ps3soundlib.sh by CrystalCT (crystal@unict.it)
# PS3 SOUNDLIB Credits: Hermes, HACKERCHANNEL, Xiph.Org, mpg123 project and Wargio/deroad

## Download the source code.
wget --no-check-certificate https://github.com/wargio/ps3soundlib/tarball/master -O ps3soundlib.tar.gz 

## Unpack the source code.
rm -Rf ps3soundlib && mkdir ps3soundlib && tar --strip-components=1 --directory=ps3soundlib -xvzf ps3soundlib.tar.gz && cd ps3soundlib

## Compile and install.
${MAKE:-make}
