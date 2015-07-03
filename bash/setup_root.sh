#!/bin/bash

#
# This script will return you to the necessary version of
# ROOT for reading SusyNtuples.
#
# Note: It is always better to start this from a clean working
# environment!
#

rootver=6.02.05-x86_64-slc6-gcc48-opt

echo ""
echo "Setting up ROOT ${rootver}"
localSetupROOT 6.02.05-x86_64-slc6-gcc48-opt --skipConfirm

if [ -d ${ROOTCOREDIR} ];
then
    source ${ROOTCOREDIR}/scripts/unsetup.sh
fi
source RootCore/scripts/setup.sh
rc find_packages

echo ""
echo "Done."
