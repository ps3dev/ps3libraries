#!/bin/sh -e
# libcurl-7.21.6 by KaKaRoTo

## Download the source code.
wget --no-check-certificate https://github.com/wargio/PolarSSL-PSL1GHT/tarball/master -O PolarSSL.tar.gz 

## Unpack the source code.
rm -Rf PolarSSL && mkdir PolarSSL && tar --strip-components=1 --directory=PolarSSL -xvzf PolarSSL.tar.gz && cd PolarSSL

## Compile and install.
${MAKE:-make}  CC="ppu-gcc" AR="ppu-ar" RANLIB="ppu-ranlib" -j4 && ${MAKE:-make}  CC="ppu-gcc" AR="ppu-ar" RANLIB="ppu-ranlib" install

