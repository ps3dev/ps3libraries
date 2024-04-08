#!/bin/sh

## Check for cmake.
which cmake 1> /dev/null || { echo "ERROR: Install cmake before continuing."; exit 1; }
