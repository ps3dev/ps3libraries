#!/bin/sh

submodule_options='--init --depth 1 --recursive --single-branch'

cd `dirname $0`

if expr "$1" : submodules/ >/dev/null; then
  test -d "$1"/.git -o -f "$1"/.git || exec git submodule update $submodule_options -- "$1"
  exit
fi

cd archives || exit

if [ $# -eq 0 ]; then
  git submodule update $submodule_options
  sed -e 's:^.*/::g' < archives.txt | while read file; do
    ../download.sh "$file" || exit
  done
  for i in ../submodules/*/download.sh; do
    if [ -x "$i" ]; then
      "$i"
    fi
  done
  exit
fi

if [ $# -ne 1 ]; then
  echo >&2 "Usage: $0 filename"
  exit 1
fi
file="$1"

set -- `grep "$1" archives.txt`
if [ $# -lt 3 ]; then
  echo >&2 "Unable to find $file in archives.txt"
  exit 1
fi
remote_md5="$1"
remote_size="$2"
shift
shift

if [ -s "$file" ]; then
  previous_file=yes
  if [ "$remote_size" = "-" ]; then
    local_size='-'
  else
    local_size=`stat 2>/dev/null -L -c'%s' "$file"`
  fi
else
  previous_file=no
fi

if [ $previous_file = no -o "$remote_size" != "$local_size" ]; then
  while [ "$#" -gt 0 ]; do
    if [ "$#" -gt 1 ]; then
      wget --tries 5 --timeout 15 --continue "$1" && break
    else
      wget --continue "$1" || exit
    fi
    shift
  done
fi

if [ "$remote_md5" = "-" ]; then
  local_md5='-'
else
  local_md5=`md5sum 2>/dev/null -b "$file" | cut -c 1-32`
fi
if [ -n "$local_md5" -a "$remote_md5" != "$local_md5" ]; then
  echo >&2 "Incorrect MD5 for $file"
  if [ $previous_file = yes ]; then
    echo >&2 "Deleting the file and trying again..."
    rm "$file"
    exec ../download.sh "$file"
  else
    exit 1
  fi
fi
