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

    echo "Setting up area for SusyNtuple"
    date

    if [ "${dev_or_stable}" = "--dev" ]
    then
        GIT="git@github.com:" # read+write
        echo "---------------------------------------------"
        echo " You are checking out the development"
        echo " (master) branch of SusyNtuple."
        tput setaf 1
        echo " If you mean to read SusyNt's from the n0234 "
        echo " production, please call this script with"
        echo " the '--stable' cmd line option."
        tput sgr0
        echo "---------------------------------------------"
    else
        echo "---------------------------------------------"
        tput setaf 2
        echo " You are checking out the tag of SusyNtuple  "
        echo " for the n0234 production of SusyNt."
        tput sgr0
        echo "---------------------------------------------"
    fi

    echo ""
    echo "Cloning SusyNtuple from ${GIT}susynt/SusyNtuple"
    git clone ${GIT}susynt/SusyNtuple.git

    if [ "${dev_or_stable}" = "--dev" ]
    then
        cd SusyNtuple
        echo "Checking out the master branch of SusyNtuple"
        git checkout master
        cd ..
    else
        cd SusyNtuple
        echo "Checking out the tag SusyNtuple-00-06-00"
        git checkout SusyNtuple-00-06-00
        cd ..
    fi

    # tags to checkout
    rootURL="$SVNOFF/PhysicsAnalysis/D3PDTools/RootCore/tags/RootCore-00-04-62"
    susyURL="$SVNOFF/PhysicsAnalysis/SUSYPhys/SUSYTools/tags/SUSYTools-00-08-64"

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
    sed -i "s/^PACKAGE_REFLEX.*/PACKAGE_REFLEX = /" SUSYTools/cmt/Makefile.RootCore
    # sed -i "s/^PACKAGE_DEP.*/PACKAGE_DEP = CalibrationDataInterface/" SUSYTools/cmt/Makefile.RootCore

    # patch for 07-82: drop dependecy on PathResolver
    patch -p0 < SUSYCrossSection.patch

    echo ""
    echo "Finished."
    date
}
#-----------------------------------------------------------
function main() {
    # parse as in
    # http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
    local dev_or_stable="--stable"
    local help=""
    while [[ $# > 0 ]]
    do
        key="$1"
        case $key in
            --dev)
                dev_or_stable="--dev"
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
