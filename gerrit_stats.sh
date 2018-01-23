#!/bin/bash

user=$GERRIT_USER
pushd /stats &> /dev/null
rm -rf gerrit_out
mkdir gerrit_out
./gerrit_downloader.sh --server http://$user@gerrit.xgrid.co:29418 --output-dir gerrit_out/
./gerrit_stats.sh -f gerrit_out/
popd &> /dev/null
