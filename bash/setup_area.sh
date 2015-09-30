#!/bin/bash

#
# This script will checkout SusyNtuple as well as the necessary 
# packages/dependencies to run over the SusyNt tag requested by 
# the user
#
# Note: This checks out packages from SVN, so you may be asked 
# to provide your CERN password. Doing "kinit" before running
# this script is helpful.
#
# daniel.joseph.antrim@cern.ch
# July 3 2015
#


#-----------------------------------------------------------
function print_usage() {
    echo "Usage:"
    echo "source setup_area.sh [--dev] [--help]"
    echo " --dev: checkout the master."
    echo "        By default checkout the latest stable SusyNtuple tag."
    echo " --help:   print this message"
}
#-----------------------------------------------------------
function setup_area() {
    local dev_or_stable="$1"
    local SVNOFF="svn+ssh://svn.cern.ch/reps/atlasoff/"
    local SVNPHYS="svn+ssh://svn.cern.ch/reps/atlasphys/"
    local GIT="https://github.com/" # read-only
    if [ "${dev_or_stable}" = "dev" ]
        then
        GIT="git@github.com:" # read+write
    fi

    echo "Setting up area for SusyNtuple"
    date
    echo ""
    echo "Cloning SusyNtuple from ${GIT}susynt/SusyNtuple"
    git clone ${GIT}susynt/SusyNtuple.git

    if [ "${dev_or_stable}" = "stable" ]
    then
        cd SusyNtuple
        echo "Checking out the tag SusyNtuple-00-03-01"
        git checkout SusyNtuple-00-03-01
        cd ..
    fi

    # tags to checkout
    rootURL="$SVNOFF/PhysicsAnalysis/D3PDTools/RootCore/tags/RootCore-00-04-37"
    susyURL="$SVNOFF/PhysicsAnalysis/SUSYPhys/SUSYTools/tags/SUSYTools-00-06-22"

    echo "Checking out SusyNtuple dependencies"
    svn co $rootURL RootCore || return || exit

    # Only need minimal SUSYTools
    echo "Installing minimal SUSYTools"
    mkdir -p SUSYTools/SUSYTools SUSYTools/Root SUSYTools/cmt SUSYTools/data
    svn export $susyURL/SUSYTools/SUSYCrossSection.h SUSYTools/SUSYTools/SUSYCrossSection.h
    svn export $susyURL/Root/SUSYCrossSection.cxx SUSYTools/Root/SUSYCrossSection.cxx
    svn export $susyURL/cmt/Makefile.RootCore SUSYTools/cmt/Makefile.RootCore
    svn co $susyURL/data SUSYTools/data || return || exit

    # modify the SUSYTools dependencies
    sed -i "s/^PACKAGE_DEP.*/PACKAGE_DEP = /" SUSYTools/cmt/Makefile.RootCore
    # sed -i "s/^PACKAGE_DEP.*/PACKAGE_DEP = CalibrationDataInterface/" SUSYTools/cmt/Makefile.RootCore

    echo ""
    echo "Finished."
    date
}
#-----------------------------------------------------------
function main() {
    # parse as in
    # http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
    local dev_or_stable="stable"
    local help=""
    while [[ $# > 0 ]]
    do
        key="$1"
        case $key in
            --dev)
                dev_or_stable="dev"
                ;;
            -h|--help)
                help=true
                ;;
            *)
                # unknown option
                ;;
        esac
        shift # past argument or value
    done

    if [[ ${help} ]]
    then
        print_usage
    else
        setup_area ${dev_or_stable}
    fi
}

#-----------------------------------------------------------
main $*
