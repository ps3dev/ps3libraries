#!/bin/sh -e
#
# un7Zip library by Bucanero

## Download the source code.
wget https://github.com/bucanero/libun7zip/tarball/master -O libun7zip.tar.gz 

## Unpack the source code.
rm -Rf libun7zip && mkdir libun7zip && tar --strip-components=1 --directory=libun7zip -xvzf libun7zip.tar.gz && cd libun7zip

## Compile and install.
${MAKE:-make} install
