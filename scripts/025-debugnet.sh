#!/bin/sh -e
# debugnet.sh by Sergio Padrino (@sergiou87)

## Download the source code.
wget --no-check-certificate https://github.com/sergiou87/ps3debugnet/tarball/master -O ps3debugnet.tar.gz

## Unpack the source code.
rm -Rf ps3debugnet && mkdir ps3debugnet && tar --strip-components=1 --directory=ps3debugnet -xvzf ps3debugnet.tar.gz

cd ps3debugnet/libdebugnet

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
