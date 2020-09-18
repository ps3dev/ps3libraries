#!/bin/sh -e
# ps3soundlib.sh by CrystalCT (crystal@unict.it)
# PS3 SOUNDLIB Credits: Hermes, HACKERCHANNEL, Xiph.Org, mpg123 project and Wargio/deroad

## Download the source code.
../download.sh submodules/ps3soundlib

## Unpack the source code.
rm -Rf ps3soundlib && mkdir ps3soundlib && git --git-dir=../submodules/ps3soundlib/.git --work-tree=ps3soundlib checkout-index -a && cd ps3soundlib

## Compile and install.
${MAKE:-make}
