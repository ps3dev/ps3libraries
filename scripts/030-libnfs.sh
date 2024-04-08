#!/bin/sh -e
#
# libnfs by sahlberg
#	ported to PS3 by Bucanero

## Download the source code.
owner=sahlberg
repo=libnfs
tag_latest=`wget -qO- "https://api.github.com/repos/${owner}/${repo}/tags" | grep -o '"name": "[^"]*' | cut -d'"' -f4 | head -n1`
wget https://github.com/${owner}/${repo}/archive/refs/tags/${tag_latest}.tar.gz -O libnfs.tar.gz 

## Unpack the source code.
rm -Rf libnfs && mkdir libnfs && tar --strip-components=1 --directory=libnfs -xvzf libnfs.tar.gz && cd libnfs

## Compile and install.
${MAKE:-make} -f ps3_ppu/Makefile.PS3_PPU install