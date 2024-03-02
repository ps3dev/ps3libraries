#!/bin/sh -e
# pthreads-emb.sh by Humberto Dias

## Download the source code.
wget https://github.com/humbertodias/pthread-emb-ps3/tarball/master -O pthreads-emb.tar.gz

## Unpack the source code.
rm -Rf pthreads-emb && mkdir pthreads-emb && tar --strip-components=1 --directory=pthreads-emb -xvzf pthreads-emb.tar.gz

## Create the build directory.
cd pthreads-emb/src/platform/psl1ght

## Compile and install.
${MAKE:-make} && ${MAKE:-make} install
