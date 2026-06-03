#!/bin/sh
# check-libtool.sh by Naomi Peori (naomi@peori.ca)

## Check for libtool.
case "$(uname -s)" in
  Darwin*)
    libtool -V >/dev/null 2>&1 || { echo "ERROR: Install libtool before continuing."; exit 1; }
    ;;
  *)
    { libtool --version || libtool -V; } >/dev/null 2>&1 || { echo "ERROR: Install libtool before continuing."; exit 1; }
    ;;
esac