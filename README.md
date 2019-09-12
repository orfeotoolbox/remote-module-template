# General

[![Build Status](https://travis-ci.org/orfeotoolbox/remote-module-template.svg?branch=master)](https://travis-ci.org/orfeotoolbox/remote-module-template)

This is a template module for the ORFEO
Toolbox(https://www.orfeo-toolbox.org/). It is designed to work with OTB >= 5.0
modular system. The module can be clone/copied in `OTB/Module/Remote` and
compiled along with other OTB modules. However, it is also possible to build it
as a standalone module.

This module is filled with a few templates to be used as a starting point for a
module with actual content. It contains the templates for:

* a library (`cxx` source in `src` folder)
* headers and templated classes (`include` folder)
* a OTB Application (`app` folder)
* tests for C++ sources, applications and python wrappers (`test` folder)

This module also has its own continuous integration scripts (using Travis CI).

# Getting Started

The official OTB Wiki documentation on adding an external module is
[here](http://wiki.orfeo-toolbox.org/index.php/How_to_write_a_remote_module).

## Remote Module

After a module has been created as a git repository it can be included
as a remote module, which enables automatic fetching. Add a file in
"OTB/Modules/Remote" called "YourModule.remote.cmake", for this module
it would be "ExternalExample.remote.cmake" with the followlowing contents:

```
otb_fetch_module(ExternalTemplate
  "A template for a module."
  GIT_REPOSITORY https://github.com/orfeotoolbox/otbExternalModuleTemplate
  GIT_TAG master
  )
```

### Editing

The files `CMakeLists.txt` and `otb-module.cmake` need to be modified with the name of the
module, something along the following:

```
sed 's/ExternalTemplate/MyModule/g' CMakeLists.txt otb-module.cmake
```

There is the inplace option to sed, but it's not portable, so do this change by
hand or look up the option in sed.

Then hack away at you code in include, src, test and app folders.

### Continuous Integration

This module contains default files to enable Continuous Integration on
Travis-CI:

* `travis-ci.yml` : this is the backbone of the CI process in Travis-CI, it
  defines the different jobs to run, and their environment
* `ci.cmake` : this CTest script drives the build and test process.
* `vcvars_proxy.py` : this script is used on Windows to export variables from
  `vcvarsall.bat` to the Git-Bash executor.

The `README.md` starts with a Travis-CI badge, you can change it to match your
own module.

If you need to access data file from `OTB/Data`, you can tune the file
`ci.cmake` which will download them for you before building:

* `RM_GET_FULL_DATA`: this flag will download all files under `OTB/Data`
* `RM_DATA_PATTERNS`: this variable allows to download only the files you need.
  Set this variable to a list of patterns (for instance
  `Data/Input/QB_Toulouse_*.tif`). This method should be faster.

### License

This software is distributed under the Apache License. Please see LICENSE for
details.

### Authors

Manuel Grizonnet
Guillaume Pasero

### Thanks

It is a fork of the ITK template module provided by Bradley Lowekamp
(https://github.com/blowekamp/itkExternalTemplate.git) which was adapted for the
ORFEO ToolBox.
