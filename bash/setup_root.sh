#!/bin/bash

#
# This script will return you to the necessary version of
# ROOT for reading SusyNtuples.
#
# Note: It is always better to start this from a clean working
# environment!
#

rootver=6.02.10-x86_64-slc6-gcc48-opt

echo ""
echo "Setting up ROOT ${rootver}"
localSetupROOT ${rootver}

echo ""
echo "Done."