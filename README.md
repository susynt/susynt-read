susynt-read
===========

Example package to read SusyNt nutples

Prerequisites:
- root (`echo ${ROOTSYS}`)
- svn access and kerberos ticket (`klist`)

Follow these commands to set up an area to read SusyNtuples.

```
git clone --recursive git@github.com:gerbaudo/susynt-read.git
cd susynt-read
git submodule update --init # only needed if you did not use '--recursive'
source SusyNtuple/scripts/installMinimalSUSYTools.sh

```
