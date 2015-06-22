#!/bin/bash

#
# This script will checkout SusyNtuple as well as the necesssary
# packages to run over SusyNt's for tag n0205
#

SVNOFF="svn+ssh://svn.cern.ch/reps/atlasoff/"
SVNPHYS="svn+ssh://svn.cern.ch/reps/atlasphys/"

# checkout the SusyNtuple that was used for n0205
git clone git@github.com:susynt/SusyNtuple.git
cd SusyNtuple
git checkout SusyNtuple-00-02-03
cd -

# Tags to checkout
susyURL="$SVNOFF/PhysicsAnalysis/SUSYPhys/SUSYTools/tags/SUSYTools-00-05-00-29"
mt2URL="$SVNPHYS/Physics/SUSY/Analyses/WeakProduction/Mt2/tags/Mt2-00-00-01"
trigURL="$SVNPHYS/Physics/SUSY/Analyses/WeakProduction/DGTriggerReweight/tags/DGTriggerReweight-00-00-29"
jvfURL="$SVNOFF/Reconstruction/Jet/JetAnalysisTools/JVFUncertaintyTool/tags/JVFUncertaintyTool-00-00-04"
evtShapeURL="$SVNOFF/Reconstruction/EventShapes/EventShapeTools/tags/EventShapeTools-00-01-09" # needed by SUSYTools



# Additional checkouts for 2-lepton
svn co $mt2URL Mt2 || return || exit
svn co $trigURL DGTriggerReweight || return || exit
svn co $jvfURL JVFUncertaintyTool || return || exit
svn co $evtShapeURL EventShapeTools || return || exit

# Checkout minimal SUSYTools
mkdir -p SUSYTools/SUSYTools SUSYTools/Root SUSYTools/cmt SUSYTools/data
svn export $susyURL/SUSYTools/SUSYCrossSection.h SUSYTools/SUSYTools/SUSYCrossSection.h
svn export $susyURL/Root/SUSYCrossSection.cxx SUSYTools/Root/SUSYCrossSection.cxx
svn export $susyURL/cmt/Makefile.RootCore SUSYTools/cmt/Makefile.RootCore
svn co $susyURL/data SUSYTools/data || return || exit


# set up the AnalysisRelease for n0205
setupATLAS
rcSetup -u; rcSetup Base,2.1.28
rc find_packages
rc compile

echo "Installation successful"
echo "You may want to update SUSYTools/data to the trunk,"
echo "in which case use the refreshSUSYToolsData.sh script"
