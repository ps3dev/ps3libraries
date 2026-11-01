#!/usr/bin/env bash
set -eo pipefail
# dbglogger by Bucanero

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh dbglogger.tar.gz

## Unpack the source code.
rm -Rf dbglogger
mkdir dbglogger
echo "Unpacking dbglogger"
extract ../archives/dbglogger.tar.gz --strip-components=1 --directory=dbglogger
cd dbglogger

## Compile and install.
jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
${MAKE:-make} -j"$jobs" install
