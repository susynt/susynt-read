susynt-read
===========

# Contents
* [Introduction](#introduction)
* [Requirements](#requirements)
* [Actions](#actions)
  * [First Time Setup](#first-time-setup)
  * [Subsequent Area Setup](#subsequent-area-setup)
  * [Subsequent Compilation](#subsequent-compilation)
  * [Compiling After Changes to CMakeLists](#compiling-after-changes-to-cmakelists)
 * [Useful Scripts](#useful-scripts)

## Introduction
This packages prepares an area for reading susyNt files for physics analysis.

## Requirements
We assume that you have access to **cvmfs**, for setting up the **AnalysisBase** release, as well as **svn**:

1) access to **cvmfs** (be on a machine with cvmfs)
2) kerberos tickets (run: ```kinit -f ${USER}@CERN.CH```)

## Actions

### First Time Setup

Here are the steps to setup an area from scratch.

```
git clone -b <tag> git@github.com:susynt/susynt-read.git
cd susynt-read/
source bash/setup_area.sh --stable
source bash/setup_release.sh --compile
```

The script *bash/setup_area.sh* call in the above snippet will checkout the "stable" release given by the tag ```<tag>```. This means that it will checkout the associated tags of **SusyNtuple** and **SUSYTools** (i.e. those tags of these two packages that were used to build susyNt tag ```<tag>```). You can use the ```-h``` or ```--help``` option to see the full list of options:

```
source bash/setup_area.sh --help
```

You will see that you can give the ```--sn``` option to specify a specific tag (or branch) of **SusyNtuple**. 

The script *bash/setup_release.sh* sets up the associated **AnalysisBase** release. When given the ```--compile``` flag it will also run the full compilation of the packages checked out by the *bash/setup_area.sh* script (which should now be located under *susynt-read/source/*). You can use the ```-h``` or ```--help``` option to see the full list of options:

```
source bash/setup_release.sh --help
```

After running *bash/setup_release.sh* with the ```--compile``` flag you will see the *susynt-read/build/* directory which contains the typical ```CMake```-like build directory structure. In order to allow all executables be in the user's path, the *bash/setup_release.sh* script sources the *setup.sh* script located in *susynt-read/build/x86_64-\*/* directory.

### Subsequent Area Setup

If you are returning to your *susynt-read/* directory from a new shell and you have previously compiled all of the software, you need to still setup the environment so that all of the executables, librarires, etc... can be found. You can do this simply by calling the *bash/setup_release.sh* script with no arguments:

```
source bash/setup_release.sh
```

This sources the *setup.sh* script located in *susynt-read/build/x86_64-\8/* directory.

### Subsequent Compilation

You can either call:

```
source bash/setup_release.sh --compile
```

every time you wish to compile. But this runs the *cmake* command to initiate the ```CMake``` configuration steps. This also removes the previous *build/* directory and starts a new one.

The simpler and faster way (and therefore recommended way) is to move to the *build/* directory and simply call ```make```:

```
cd build/
make
```

### Compiling After Changes to CMakeLists

If you change any of the ```CMakeLists.txt``` files in any of the packages in *susynt-read/source/* directory, you need to re-run the ```CMake``` configuration. You can do this simply by running:

```
source bash/setup_release.sh --compile
```

or, if you do not want to completely remove the previous *build/* directory (and are sure that your changes are OK for this) you can simply do:

```
cd build/
cmake ../source
make
```

## Useful Scripts

### Listing Available Datasets
There is the ```python``` script *python/available_datasets* which will provide you with text files for all of the **mc** and **data** susyNt samples for the given production tag. Run it as follows:

```
./python/available_datasets
```

or

```
python python/available_datasets
```

