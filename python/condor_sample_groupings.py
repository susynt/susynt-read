#!/bin/env python

#################################################
# This script will make a directory structure
# wherein each directory corresponds to a
# specific background and in it there will be
# the condor *.txt files made by the script
# "make_condor_lists.py" corresponding to that
# background process
#
# REQUIREMENTS BEFORE RUNNING :
#   You must have a directory containing
#   condor filelists of the same format
#   as those provided by the script
#   "make_condor_lists.py":
#    mc15_13TeV.<DSID>.foo.bar.txt
#
# daniel.joseph.antrim@cern.ch
# March 1 2016
##################################################

import os
import sys
import argparse
import subprocess
import glob

# make this global, fill below
groups = {}

def main() :
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input", help = "Provide the directory " \
                        "containing the condor lists you wish to regroup",
                        required = True)
    parser.add_argument("-o", "--output", help = "Provide the directory " \
                        "wherein you would like to put the reqrouped lists")
    args = parser.parse_args()
    indir = args.input
    outdir = args.output

    define_groups()

    input_lists = []
    if os.path.isdir(indir) :
        input_lists = get_lists(indir)

    # find/build the groups in the user-provided input directory
    out_samples = {}
    for key in groups.keys() :
        out_samples[key] = []
        dsids = groups[key]
        n_expected = len(dsids)
        for ds in dsids :
            ds_found = False
            for sample in input_lists :
                if str(ds) in sample :
                    out_samples[key].append(sample)
                    ds_found = True
            if not ds_found :
                print "WARNING Did not find DSID %d from sample group "\
                      "%s"%(ds, key)

    print "++ " + 75*"-" + " ++"
    # now that we have the groupings, make the directories 
    # to store the lists in
    if not outdir.endswith("/") :
        outdir = outdir + "/"
    for key in out_samples.keys() :
        dir_for_this_sample = outdir + key
        cmd = "mkdir -p %s"%dir_for_this_sample
      #  subprocess.call(cmd, shell=True)
        print "Storing sample %s with %d datasets in %s"%(key,
                                                        len(out_samples[key]),
                                                        dir_for_this_sample)
        for sample in out_samples[key] :
            cmd = "cp %s %s"%(sample, dir_for_this_sample)
         #   subprocess.call(cmd, shell=True)
    print "++ " + 75*"-" + " ++"

#########################################
# open up a directory and get all *.txt
# files
def get_lists(indir = "") :
    if indir == "" :
        print "get_lists ERROR: input directory is \"\""
        sys.exit()
    check_dir = indir
    if not indir.endswith("/") :
        check_dir += "/"
    lists_ = glob.glob(check_dir + "*.txt")
    print "get_lists Found %d lists in directory %s"%(len(lists_),
                                                             check_dir)
    return lists_

###########################################
# fill the groups with the expected dsids
def define_groups() :
    groups['drellyan_sherpa'] = [
        361468,
        361469,
        361470,
        361471,
        361472,
        361473,
        361474,
        361475,
        361476,
        361477,
        361478,
        361479,
        361480,
        361481,
        361482,
        361483,
        361484,
        361485,
        361486,
        361487,
        361488,
        361489,
        361490,
        361491]

    groups['diboson_powheg'] = [
        361600,
        361601,
        361603,
        361604,
        361607,
        361610]

    groups['bwn'] = [
        406009,
        406010,
        406011]

    groups['diboson_sherpa'] = [
        361063,
        361064,
        361065,
        361066,
        361067,
        361068,
        361069,
        361070,
        361071,
        361072,
        361073,
        361074,
        361077,
        361078,
        361079,
        361080,
        361084,
        361085,
        361086]

    groups['singletop'] = [
        410011,
        410012,
        410015,
        410016,
        410025,
        410026]

    groups['ttbar'] = [
        410009]

    groups['wjets_powheg'] = [
        361100,
        361101,
        361102,
        361103,
        361104,
        361105]

    groups['wjets_sherpa'] = [
        361300,
        361301,
        361302,
        361303,
        361304,
        361305,
        361306,
        361307,
        361308,
        361309,
        361310,
        361311,
        361312,
        361313,
        361314,
        361315,
        361316,
        361317,
        361318,
        361319,
        361320,
        361321,
        361322,
        361323,
        361324,
        361325,
        361326,
        361327,
        361328,
        361329,
        361330,
        361331,
        361332,
        361333,
        361334,
        361335,
        361336,
        361337,
        361338,
        361339,
        361340,
        361341,
        361342,
        361343,
        361344,
        361345,
        361346,
        361347,
        361348,
        361349,
        361350,
        361351,
        361352,
        361353,
        361354,
        361355,
        361356,
        361357,
        361358,
        361359,
        361360,
        361361,
        361362,
        361363,
        361364,
        361365,
        361366,
        361367,
        361368,
        361369,
        361370,
        361371]

    groups['zjets_powheg'] = [
        361106,
        361107,
        361108]

    groups['zjets_sherpa'] = [
        361372,
        361373,
        361374,
        361375,
        361376,
        361377,
        361378,
        361379,
        361380,
        361381,
        361382,
        361383,
        361384,
        361385,
        361386,
        361387,
        361388,
        361389,
        361390,
        361391,
        361392,
        361393,
        361394,
        361395,
        361396,
        361397,
        361398,
        361399,
        361400,
        361401,
        361402,
        361403,
        361404,
        361405,
        361406,
        361407,
        361408,
        361409,
        361410,
        361411,
        361412,
        361413,
        361414,
        361415,
        361416,
        361417,
        361418,
        361419,
        361420,
        361421,
        361422,
        361423,
        361424,
        361425,
        361426,
        361427,
        361428,
        361429,
        361430,
        361431,
        361432,
        361433,
        361434,
        361435,
        361436,
        361437,
        361438,
        361439,
        361440,
        361441,
        361442,
        361443,
        361444,
        361445,
        361446,
        361447,
        361448,
        361449,
        361450,
        361451,
        361452,
        361453,
        361454,
        361455,
        361456,
        361457,
        361458,
        361459,
        361460,
        361461,
        361462,
        361463,
        361464,
        361465,
        361466,
        361467]

#########################################
if __name__=="__main__" :
    define_groups()
    main()

