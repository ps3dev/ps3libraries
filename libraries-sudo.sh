#!/bin/sh
# libraries-sudo.sh by Dan Peori (danpeori@oopo.net)

## Enter the ps3libraries directory.
cd "`dirname $0`" || { echo "ERROR: Could not enter the ps3libraries directory."; exit 1; }

## Set up the environment.
export PS3DEV=/usr/local/ps3dev
export PATH=$PATH:$PS3DEV/bin
export PATH=$PATH:$PS3DEV/ppu/bin
export PATH=$PATH:$PS3DEV/spu/bin

## Run the libraries script.
./libraries.sh $@ || { echo "ERROR: Could not run the libraries script."; exit 1; }
