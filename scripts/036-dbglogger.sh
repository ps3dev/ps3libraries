#!/bin/sh -e
# dbglogger by Bucanero

## Download the source code.
wget https://github.com/bucanero/dbglogger/tarball/master -O dbglogger.tar.gz 

## Unpack the source code.
rm -Rf dbglogger && mkdir dbglogger && tar --strip-components=1 --directory=dbglogger -xvzf dbglogger.tar.gz && cd dbglogger

## Compile and install.
${MAKE:-make} install
