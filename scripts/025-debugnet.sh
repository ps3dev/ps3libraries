#!/bin/sh -e
# debugnet.sh by Sergio Padrino (@sergiou87)

## Download the source code.
../download.sh submodules/ps3debugnet

## Unpack the source code.
rm -Rf ps3debugnet && mkdir ps3debugnet && git --git-dir=../submodules/ps3debugnet/.git --work-tree=ps3debugnet checkout-index -a

cd ps3debugnet/libdebugnet

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
