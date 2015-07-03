susynt-read
===========

Package to prepare a working area for reading SusyNtuples.

#Prerequisites:
- svn access and kerberos ticket (`klist`)
- Run `kinit` beforehand if no kerberos ticket established (you will be asked for your CERN password during `setup_area` otherwise)
- Access to cvmfs (for setting up an AnalysisRelease)

#Follow these commands to set up an area to read SusyNtuples.

```
git clone -b mc15 https://github.com/susynt/susynt-read.git
cd susynt-read
source bash/setup_area.sh
source bash/setup_release.sh
```

For a list of available SusyNt datasets for the recent production:
```
source bash/available_datasets.sh
```
This will produce two filelists using dq2: one for monte-carlo and one for data.
