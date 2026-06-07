#!/bin/sh -e
#
# pthread-emb ps3 library

## Download the source code.
../download.sh pthread-emb-ps3.tar.gz

## Unpack the source code.
rm -Rf pthread-emb-ps3 && mkdir pthread-emb-ps3 && tar --strip-components=1 --directory=libunrar -xvzf ../archives/pthread-emb-ps3.tar.gz && cd pthread-emb-ps3/platform/psl1ght

## Compile and install.
${MAKE:-make} install
