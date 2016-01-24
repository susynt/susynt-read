#!/bin/bash

#
# This script will make output .txt files containing
# the SusyNt files for the current tag.
#
# daniel.joseph.antrim@cern.ch
# July 3 2015
#

thisTag="n0218b"
mcOut="${thisTag}_mcSusyNt.txt"
dataOut="${thisTag}_dataSusyNt.txt"

echo ""
echo "Setting up DQ2"
echo "lsetup dq2"
date
lsetup dq2

echo "Looking for mc15"
echo "_____________________________________________________________________________"
echo "dq2-ls user.dantrim:user.dantrim.mc15_13TeV.*.SusyNt.*${thisTag}*_nt/"
dq2-ls user.dantrim:user.dantrim.mc15_13TeV.*.SusyNt.*${thisTag}*_nt/ 2>&1 |sort |tee ${mcOut}

echo ""
echo "Looking for data15"
echo "_____________________________________________________________________________"
echo "dq2-ls user.dantrim:user.dantrim.data15_13TeV.*.SusyNt.*${thisTag}*_nt/"
dq2-ls user.dantrim:user.dantrim.data15_13TeV.*.SusyNt.*${thisTag}*_nt/ 2>&1 |sort |tee ${dataOut}

echo ""
echo "Finished."
echo "mc15 filelist: ${mcOut}"
echo "data15 filelist: ${dataOut}"
date

