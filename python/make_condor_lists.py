#!/bin/env python

#######################################################
# This script will make lists of the FAX/xROOTD paths
# for a given input text file that contains on each
# line a file container name (can be either SusyNt
# or otherwise as long as each line is a dataset
# container that can be retrieved via 'dq2-ls')
#
# REQUIREMENTS BEFORE RUNNING:
#    localSetupFAX
#    grid proxy (voms-init-proxy -voms atlas)
#
# daniel.joseph.antrim@cern.ch
# October 2015
#######################################################

import os
import sys
import argparse
import subprocess
import commands

def main() :
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input", help="Provide a .txt file containing the list of dataset containers", required=True)
    parser.add_argument("-o", "--output", help="Provide the output directory name to store the output lists in", required=True)
    args = parser.parse_args()
    input = args.input
    output = args.output

    input_containers = []
    if os.path.isfile(input) :
        input_containers = get_containers(open(input).readlines())

    if len(input_containers) == 0 :
        print "Input containers list is empty!"
        sys.exit()

    total_n = len(input_containers)
    n_read = 0

    print "Checking that FAX is set-up"
    if os.environ.get('STORAGEPREFIX') == None :
        print "STORAGEPREFIX environment variable is empty!"
        print "You must call 'localSetupFAX' before calling this script."
        sys.exit()

    for container in input_containers :
        n_read += 1
        files = get_FAX_files(container)

        out_text_filename = get_out_filename(container)

        ofile = open(out_text_filename, "w") 
        for f in files :
            ofile.write(f + "\n")
        ofile.close()

        mv_file_to_dir(out_text_filename, output, total_n, n_read)

        if os.path.isfile("tmp_%s.txt"%container[:-2]) :
            cmd = "rm tmp_%s.txt"%container[:-2]
            commands.getoutput(cmd)

    print "Done making lists for CONDOR"
    print " > files saved in directory : %s"%output

def get_containers(container_list = []) :
    out_containers = []
    for con in container_list :
        con = con.strip()
        out_containers.append(con)

    return out_containers

def get_FAX_files(container_ = "") :
    out_files = []
    # Check if container contains 0 Bytes
    out = subprocess.check_output(['rucio', 'list-files', container_])
    if "Total files : 0" in out:
        print "No files in", container_
        return out_files

    cmd = "fax-get-gLFNs %s > tmp_%s.txt"%(container_, container_[:-2]) 
    subprocess.call(cmd, shell=True)

    files_ = open("tmp_%s.txt"%container_[:-2]).readlines()
    for file in files_ :
        if not file : continue
        file = file.strip()
        out_files.append(file)
    return out_files

def get_out_filename(container_ = "") :
    if container_=="" :
        print "get_out_filename ERROR    input container name is empty. Exiting."
        sys.exit()
    name = container_
    if ":" in name :
        name = name.split(":")
        name = name[1]
    name = name.replace("_nt", "")
    if name.endswith("/") :
        name = name[:-1]
    name = name + ".txt"
    return name


########################################
## methods for moving output
def mkdir_if_needed(dest) :
    if not os.path.isdir(dest) :
        print "Making output directory: %s"%dest
        cmd = "mkdir -p %s" % str(dest)
        commands.getoutput(cmd)

def mv_file_to_dir(filename, destdir, total_files, total_read) :

    mkdir_if_needed(destdir)
    print "[%s/%s] %s > %s"%(str(total_read), str(total_files),filename, destdir)
    cmd = "mv %s %s"%(filename, destdir)
    commands.getoutput(cmd)
    
        
    
    

   



if __name__=="__main__" :
    main()
