#!/bin/sh
# check-libtool.sh by Dan Peori (danpeori@oopo.net)

## Check for libtool.
libtool --version 1> /dev/null || { echo "ERROR: Install libtool before continuing."; exit 1; }
