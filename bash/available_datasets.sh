#!/bin/bash

#
# This script will make output .txt files containing
# the SusyNt files for the current tag.
#
# daniel.joseph.antrim@cern.ch
# July 3 2015
#

thisTag="n0209"
mcOut="${thisTag}_mcSusyNt.txt"
dataOut="${thisTag}_dataSusyNt.txt"

echo ""
echo "Setting up DQ2"
echo "localSetupDQ2Client --skipConfirm"
date
localSetupDQ2Client --skipConfirm

echo "Looking for mc15"
echo "dq2-ls group.phys:group.phys.mc15_13TeV.*.SusyNt.*${thisTag}_nt/"
dq2-ls group.phys:group.phys.mc15_13TeV.*.SusyNt.*${thisTag}_nt/ 2>&1 |sort |tee ${mcOut}
echo "dq2-ls user.dantrim:user.dantrim.mc15_13TeV.*.SusyNt.*${thisTag}_nt/"
dq2-ls user.dantrim:user.dantrim.mc15_13TeV.*.SusyNt.*${thisTag}_nt/ 2>&1 |sort |tee --append ${mcOut}

echo ""
echo "Loking for data15"
echo "dq2-ls group.phys:group.phys.data15_13TeV.*.SusyNt.*${thisTag}_nt/"
dq2-ls group.phys:group.phys.data15_13TeV.*.SusyNt.*${thisTag}_nt/ 2>&1 |sort |tee ${dataOut}
echo "dq2-ls user.dantrim:user.dantrim.data15_13TeV.*.SusyNt.*${thisTag}_nt/"
dq2-ls user.dantrim:user.dantrim.data15_13TeV.*.SusyNt.*${thisTag}_nt/ 2>&1 |sort |tee --append ${dataOut}

echo ""
echo "Finished."
echo "mc15 filelist: ${mcOut}"
echo "data15 filelist: ${dataOut}"
date

