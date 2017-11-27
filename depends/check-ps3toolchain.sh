#!/bin/sh
# check-ps3toolchain.sh by Naomi Peori (naomi@peori.ca)

## Check for ps3-gcc.
ppu-gcc --version 1> /dev/null || { echo "ERROR: Install the ps3toolchain before continuing."; exit 1; }
