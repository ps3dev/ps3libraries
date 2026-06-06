#!/bin/sh -e
# sdl_psl1ght.sh by Naomi Peori (naomi@peori.ca)

## Unpack the source code.
rm -Rf sdl_psl1ght
mkdir sdl_psl1ght
echo "Unpacking sdl_psl1ght"
pv -pterb ../downloads/sdl_psl1ght.tar.gz | tar --strip-components=1 --directory=sdl_psl1ght -xzf -
cd sdl_psl1ght

## Compile and install.
./script.sh && ${MAKE:-make} && ${MAKE:-make} install
