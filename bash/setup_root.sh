#!/bin/bash

#
# This script will return you to the necessary version of
# ROOT for reading SusyNtuples.
#
# Note: It is always better to start this from a clean working
# environment!
#

rootver=6.04.12-x86_64-slc6-gcc49-opt

echo ""
echo "Setting up ROOT ${rootver}"
lsetup "root ${rootver} --skipConfirm"

echo ""
echo "Done."
