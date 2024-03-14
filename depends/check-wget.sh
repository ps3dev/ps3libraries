#!/bin/sh
# check-wget.sh by Naomi Peori (naomi@peori.ca)

## Check for wget.
wget -V 1> /dev/null || { echo "ERROR: Install wget before continuing."; exit 1; }

## Setup global wget configuration
## https://www.gnu.org/software/wget/manual/html_node/Wgetrc-Commands.html
echo "
# If this is set to off, the server certificate is not checked against the specified client authorities. The default is “on”
check_certificate = off
# Tune HTTPS security (auto, SSLv2, SSLv3, TLSv1, PFS)
secureprotocol = auto
# You can lower (or raise) the default number of retries when downloading a file (default is 20).
tries = 30
# Set all applicable timeout values to n, the same as ‘-T n’.
timeout = 15
# Specifies the maximum number of redirections to follow for a resource. See ‘--max-redirect=number’.
max_redirect = 50
# no_clobber option, will not overwrite existing files. Instead, it will skip downloading files that already exist locally.
no_clobber = on
# If set to on, force continuation of preexistent partially retrieved files. See ‘-c’ before setting it.
continue = on
# quiet (default is no)
quiet = on
" > ~/.wgetrc
