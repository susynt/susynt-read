#!/bin/bash

#
# This script setups up the release/root version for the area
# to run over the requested SusyNt tag.
#
# daniel.joseph.antrim@cern.ch
# July 3 2015
#

rootver=6.04.16-x86_64-slc6-gcc49-opt
echo ""
echo "Setting up ROOT ${rootver}"
lsetup "root ${rootver} --skipConfirm"

# if rootcore is already set up, clean up the env
if [ -d ${ROOTCOREDIR} ];
then
    source ${ROOTCOREDIR}/scripts/unsetup.sh
fi
source RootCore/scripts/setup.sh
rc find_packages
rc clean
rc compile

