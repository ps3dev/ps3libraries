#!/bin/sh
# check-cmake.sh

## Check for cmake.
cmake --version 1> /dev/null || { echo "ERROR: Install cmake before continuing."; exit 1; }
