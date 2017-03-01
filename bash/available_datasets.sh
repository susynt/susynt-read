#!/bin/bash

#
# This script will make output .txt files containing
# the SusyNt files for the current tag.
#
# daniel.joseph.antrim@cern.ch
# July 3 2015
#

thisTag="n0232"
mcOut="${thisTag}_mcSusyNt.txt"
data15Out="${thisTag}_data15SusyNt.txt"
data16Out="${thisTag}_data16SusyNt.txt"

echo ""
echo "Setting up Rucio"
echo "lsetup rucio"
date
lsetup rucio

echo "Looking for mc15"
echo "_____________________________________________________________________________"
echo "rucio ls group.phys-susy:group.phys-susy.mc15_13TeV.*.SusyNt.*${thisTag}*_nt/"
rucio ls group.phys-susy:group.phys-susy.mc15_13TeV.*.SusyNt.*${thisTag}*_nt/ |grep CONTAINER |sed 's/|//g' |sed 's/CONTAINER//g' |sed 's/nt/nt\//g' |sed 's/ //g' 2>&1 |sort |tee ${mcOut} 

echo ""
echo "Looking for data15"
echo "_____________________________________________________________________________"
echo "rucio ls group.phys-susy:group.phys-susy.data15_13TeV.*.SusyNt.*${thisTag}*_nt/" 
rucio ls group.phys-susy:group.phys-susy.data15_13TeV.*.SusyNt.*${thisTag}*_nt/  |grep CONTAINER |sed 's/|//g' |sed 's/CONTAINER//g' |sed 's/nt/nt\//g' |sed 's/ //g' 2>&1 |sort |tee ${data15Out} 

echo ""
echo "Looking for data16"
echo "_____________________________________________________________________________"
echo "rucio ls group.phys-susy:group.phys-susy.data16_13TeV.*.SusyNt.*${thisTag}*_nt/" 
rucio ls group.phys-susy:group.phys-susy.data16_13TeV.*.SusyNt.*${thisTag}*_nt/ |grep CONTAINER |sed 's/|//g' |sed 's/CONTAINER//g' |sed 's/nt/nt\//g' |sed 's/ //g' 2>&1 |sort |tee ${data16Out} 


echo ""
echo "Finished."
echo "mc15 filelist: ${mcOut}"
echo "data15 filelist: ${data15Out}"
echo "data16 filelist: ${data16Out}"
date

