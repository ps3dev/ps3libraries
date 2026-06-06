#!/bin/sh -e
# libNoRSX.sh by wargio (wargio@libero.it)

## Unpack the source code.
rm -Rf NoRSX
mkdir NoRSX
echo "Unpacking NoRSX"
pv -pterb ../downloads/NoRSX-master.tar.gz | tar --strip-components=1 --directory=psl1ght -xzf -
cd NoRSX

## Compile and install.
${MAKE:-make}
