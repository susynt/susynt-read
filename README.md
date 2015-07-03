susynt-read
===========

Package to prepare a working area for reading SusyNtuples.

#Prerequisites:
- svn access and kerberos ticket (`klist`)
- Run `kinit` beforehand if no kerberos ticket established (you will be asked for your CERN password during `setup_area` otherwise)
- Access to cvmfs (for setting up an AnalysisRelease)

#Follow these commands to set up an area to read SusyNtuples.

```
git clone https://github.com/susynt/susynt-read.git
cd susynt-read
git checkout <tag>
source bash/setup_area.sh
source bash/setup_release.sh
```
Where `<tag>` is your desired SusyNt tag that you want to read. The available tags are in the "releases" section
at the top of this page or at [releases](https://github.com/susynt/susynt-read/releases).

For a list of available SusyNt datasets for the recent production:
```
source bash/available_datasets.sh
```
This will produce two filelists using dq2: one for monte-carlo and one for data.
