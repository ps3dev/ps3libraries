#!/bin/sh
# check-pkg-config.sh by Naomi Peori (naomi@peori.ca)

## Check for pkg-config.
pkg-config --version 1> /dev/null || { echo "ERROR: Install pkg-config before continuing."; exit 1; }
