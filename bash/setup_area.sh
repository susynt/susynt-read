#!/bin/bash

#
# This script will checkout SusyNtuple as well as the necessary 
# packages/dependencies to run over SusyNt's tag n0206pup
#
# Note: This checks out packages from SVN, so you may be asked 
# to provide your CERN password. Doing "kinit" before running
# this script is helpful.
#
# daniel.joseph.antrim@cern.ch
# July 3 2015
#

SVNOFF="svn+ssh://svn.cern.ch/reps/atlasoff/"
SVNPHYS="svn+ssh://svn.cern.ch/reps/atlasphys/"

echo "Setting up area for SusyNtuple"
date
echo ""
echo "Cloning SusyNtuple from https://github.com/susynt/SusyNtuple"
git clone https://github.com/susynt/SusyNtuple.git
cd SusyNtuple
echo "Checking out the tag SusyNtuple-00-02-06"
git checkout SusyNtuple-00-02-06
cd ..


# tags to checkout
rootURL="$SVNOFF/PhysicsAnalysis/D3PDTools/RootCore/tags/RootCore-00-04-36"
calURL="$SVNOFF/PhysicsAnalysis/JetTagging/JetTagPerformanceCalibration/CalibrationDataInterface/tags/CalibrationDataInterface-00-05-05"
rewURL="$SVNOFF/PhysicsAnalysis/AnalysisCommon/ReweightUtils/tags/ReweightUtils-00-02-17"
susyURL="$SVNOFF/PhysicsAnalysis/SUSYPhys/SUSYTools/tags/SUSYTools-00-06-15"
mt2URL="$SVNPHYS/Physics/SUSY/Analyses/WeakProduction/Mt2/tags/Mt2-00-00-01"
trigURL="$SVNPHYS/Physics/SUSY/Analyses/WeakProduction/DGTriggerReweight/tags/DGTriggerReweight-00-00-29"
jvfURL="$SVNOFF/Reconstruction/Jet/JetAnalysisTools/JVFUncertaintyTool/tags/JVFUncertaintyTool-00-00-04"

echo "Checking out SusyNtuple dependencies"
svn co $rootURL RootCore || return || exit
svn co $calURL CalibrationDataInterface || return || exit
svn co $rewURL ReweightUtils || return || exit
svn co $mt2URL Mt2 || return || exit
svn co $trigURL DGTriggerReweight || return || exit
svn co $jvfURL JVFUncertaintyTool || return || exit

# Only need minimal SUSYTools
mkdir -p SUSYTools/SUSYTools SUSYTools/Root SUSYTools/cmt SUSYTools/data
svn export $susyURL/SUSYTools/SUSYCrossSection.h SUSYTools/SUSYTools/SUSYCrossSection.h
svn export $susyURL/Root/SUSYCrossSection.cxx SUSYTools/Root/SUSYCrossSection.cxx
svn export $susyURL/cmt/Makefile.RootCore SUSYTools/cmt/Makefile.RootCore
svn co $susyURL/data SUSYTools/data || return || exit

# modify the SUSYTools dependencies
sed -i "s/^PACKAGE_DEP.*/PACKAGE_DEP = CalibrationDataInterface/" SUSYTools/cmt/Makefile.RootCore

echo ""
echo "Finished."
date
