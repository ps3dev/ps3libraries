#!/bin/sh -e
# polarssl by deroad

## Download the source code.
wget --no-check-certificate https://github.com/wargio/polarssl/tarball/master -O polarssl.tar.gz 

## Unpack the source code.
rm -Rf polarssl && mkdir polarssl && tar --strip-components=1 --directory=polarssl -xvzf polarssl.tar.gz && cd polarssl

## Compile and install.
${MAKE:-make} -f Makefile.psl1ght -j4 && ${MAKE:-make} -f Makefile.psl1ght install

