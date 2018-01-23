#!/bin/bash

# source env variables
. <(xargs -0 bash -c 'printf "export %q\n" "$@"' -- < /proc/1/environ)
user=$GERRIT_USER
host=$GERRIT_HOST

# generate html files from fetched data
pushd /stats &> /dev/null
rm -rf gerrit_out
mkdir gerrit_out
./gerrit_downloader.sh --server http://$user@$host:29418 --output-dir gerrit_out/
./gerrit_stats.sh -f gerrit_out/
popd &> /dev/null
