susynt-read
===========

Example package to read SusyNt nutples

Prerequisites:
- root (`echo ${ROOTSYS}`)
- svn access and kerberos ticket (`klist`)

Follow these commands to set up an area to read SusyNtuples.

```
git clone git@github.com:gerbaudo/susynt-read.git
cd susynt-read
git clone git@github.com:gerbaudo/SusyNtuple # get master for now
SusyNtuple/scripts/installMinimalSUSYTools.sh 2>&1 | tee install.log

```

Todo
----

Add instructions showing how to:

- pick up a specific tag (a tag of susynt-read will pull in a specific
  tag of SusyNt; right now using master)
- add an example with a minimal selection? (RootCore `rc make_skeleton MyPackage`)
