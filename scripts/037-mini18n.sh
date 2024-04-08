#!/bin/sh -e
# mini18n by Yabause team
#   ported to PS3 by Bucanero

## Download the source code.
wget https://github.com/bucanero/mini18n/tarball/master -O mini18n.tar.gz 

## Unpack the source code.
rm -Rf mini18n && mkdir mini18n && tar --strip-components=1 --directory=mini18n -xvzf mini18n.tar.gz && cd mini18n

## Compile and install.
${MAKE:-make} install
