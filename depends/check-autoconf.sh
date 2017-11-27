#!/bin/sh
# check-autoconf.sh by Naomi Peori (naomi@peori.ca)

## Check for autoconf.
autoconf --version 1> /dev/null || { echo "ERROR: Install autoconf before continuing."; exit 1; }
