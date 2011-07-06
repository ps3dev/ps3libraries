#!/bin/sh
# check-make.sh by Dan Peori (danpeori@oopo.net)

## Check for make.
which ${MAKE:-make} 1> /dev/null || { echo "ERROR: Install make before continuing."; exit 1; }
