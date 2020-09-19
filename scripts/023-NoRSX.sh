#!/bin/sh -e
# libNoRSX.sh by wargio (wargio@libero.it)

## Download the source code.
../download.sh submodules/NoRSX

## Unpack the source code.
rm -Rf NoRSX && mkdir NoRSX && git --git-dir=../submodules/NoRSX/.git --work-tree=NoRSX checkout-index -a && cd NoRSX

## Compile and install.
${MAKE:-make}
