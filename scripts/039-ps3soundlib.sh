#!/usr/bin/env bash
set -eo pipefail
# ps3soundlib.sh by CrystalCT (crystal@unict.it)
# PS3 SOUNDLIB Credits: Hermes, HACKERCHANNEL, Xiph.Org, mpg123 project and Wargio/deroad

## Source util functions
source ../utils/utils.sh

## Download the source code.
../download.sh ps3soundlib.tar.gz 

## Unpack the source code.
rm -Rf ps3soundlib
mkdir ps3soundlib
echo "Unpacking ps3soundlib"
extract ../archives/ps3soundlib.tar.gz --strip-components=1 --directory=ps3soundlib
cd ps3soundlib

## Compile and install.
## Explodes if you use -j..
${MAKE:-make}
