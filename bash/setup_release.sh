#!/bin/bash

#
# This script setups up the release for the area
# to run over the SusyNt tag n0206pup.
#
# daniel.joseph.antrim@cern.ch
# July 3 2015
#

release=Base,2.3.14

echo ""
echo Setting up Analysis${release} and compiling packages.
date

setupATLAS
rcSetup -u; rcSetup ${release}
rc find_packages
rc clean
rc compile

echo ""
echo "Finished."
date

