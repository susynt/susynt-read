#!/bin/bash

#
# This script setups up the release/root version for the area
# to run over the requested SusyNt tag.
#
# daniel.joseph.antrim@cern.ch
# July 3 2015
#

rootVer=6.02.12-x86_64-slc6-gcc48-opt

echo ""
echo Setting up ROOT ${rootVer}
localSetupROOT ${rootVer} --skipConfirm

# if rootcore is already set up, clean up the env
if [ -d ${ROOTCOREDIR} ];
then
    source ${ROOTCOREDIR}/scripts/unsetup.sh
fi
source RootCore/scripts/setup.sh
rc find_packages
rc clean
rc compile



#release=Base,2.3.21
#
#echo ""
#echo Setting up Analysis${release} and compiling packages.
#date
#
#setupATLAS
#rcSetup -u; rcSetup ${release}
#rc find_packages
#rc clean
#rc compile
#
#echo ""
#echo "Finished."
#date

