#!/bin/bash

##############################################################
# setup_area
#
# script to checkout the packages necessary for setting
# up an area to read susyNt
#
# daniel.joseph.antrim@cern.ch
# August 2017
#
#############################################################


function print_usage {
    echo "------------------------------------------------"
    echo ""
    echo "Options:"
    echo " --stable             Checkout tag n0234(5) branches of SusyNtuple"
    echo " --master             Checkout master branch of SusyNtuple"
    echo " --sn                 Set branch/tag to checkout for SusyNtuple"
    #echo " --skip-patch         Do no tperform patch of SUSYTools"
    echo " -h|--help            Print this help message"
    echo ""
    echo "Example usage:"
    echo " - Setup the area for stable use:"
    echo "  $ source setup_area.sh --stable"
    echo " - Checkout 'cmake' branch of SusyNtuple:"
    echo "  $ source setup_area.sh --sn cmake"
    echo " NB A tag/branch for SusyNtuple is required"
    echo "------------------------------------------------"
}

function prepare_directories {
    # make source directory for dumping the code
    dirname="source/"
    if [[ -d "$dirname" ]]; then
        echo "$dirname directory exists"
    else
        echo "Creating $dirname directory"
    fi
    mkdir -p $dirname
    cp *.patch $dirname
}

function get_externals {
    skip_patch=${1}
    st_tag=${2}

    svnoff="svn+ssh://svn.cern.ch/reps/atlasoff/"
    svnphys="svn+ssh://svn.cern.ch/reps/atlasphys/"

    dirname="./source/"
    startdir=${PWD}
    if [[ -d $dirname ]]; then
        cd $dirname
    else
        echo "ERROR get_externals $dirname directory not found"
        setup_status=1
        return 1
    fi

    # checkout SUSYTools
    svncmd="svn co ${svnoff}/PhysicsAnalysis/SUSYPhys/SUSYTools/tags/${st_tag} SUSYTools"
    $svncmd
    #svn co ${svnoff}/PhysicsAnalysis/SUSYPhys/SUSYTools/tags/${st_tag} SUSYTools

    if [[ ! -d "./SUSYTools/" ]]; then
        echo "ERROR SUSYTools not checked out properly, SUSYTools/ dir not found"
        setup_status=1
        return 1
    fi

    cd ${startdir}

}

function get_susynt {

    sn_tag=${1}
    dirname="./source/"
    startdir=${PWD}
    if [[ -d $dirname ]]; then
        cd $dirname
    else
        echo "ERROR get_susynt $dirname directory not found"
        setup_status=1
        return 1
    fi

    git clone -b master git@github.com:susynt/SusyNtuple.git SusyNtuple

    if [[ ! -d "./SusyNtuple/" ]]; then
        echo "ERROR SusyNtuple not checked out properly, SusyNtuple/ dir not found"
        setup_status=1
        return 1
    fi

    cd ./SusyNtuple/
    git checkout $sn_tag
    cd -
    cd ${start_dir}

}

function main {

    sn_tag=""
    st_tag="SUSYTools-00-08-65"
    skip_patch=0

    while test $# -gt 0
    do
        case $1 in
            --stable)
                sn_tag="SusyNtuple-00-06-01" # n0234
                ;;
            --master)
                sn_tag="master"
                ;;
            --sn)
                sn_tag=${2}
                shift
                ;;
            #--skip-patch)
            #    skip_patch=1
            #    ;;
            -h)
                print_usage
                return 0
                ;;
            --help)
                print_usage
                return 0
                ;;
            *)
                echo "ERROR Invalid argument: $1"
                return 1
                ;;
        esac
        shift
    done

    if [[ $sn_tag == "" ]]; then
        echo "ERROR SusyNtuple tag is not set"
        return 1
    fi

    echo "setup_area    Starting -- `date`"
    echo "setup_area    Checking out SusyNtuple tag : $sn_tag"
    echo "setup_area    Checking out SUSYTools tag  : $st_tag"

    startdir=${PWD}
    setup_status=0
    prepare_directories
    cd ${startdir}
    get_externals $skip_patch $st_tag
    cd ${startdir}
    if [[ ${setup_status} == 1 ]]; then
        return 1
    fi
    get_susynt $sn_tag
    cd ${startdir}
    if [[ ${setup_status} == 1 ]]; then
        return 1
    fi

    echo "setup_area    Finished -- `date`"
}


main $*
