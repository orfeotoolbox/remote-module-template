# General

[![Build Status](https://travis-ci.org/orfeotoolbox/remote-module-template.svg?branch=master)](https://travis-ci.org/orfeotoolbox/remote-module-template)

This is a template module for the ORFEO
Toolbox(https://www.orfeo-toolbox.org/). It is designed to work with OTBv5
modular system and to be places in OTB/Module/Remote.

This module is empty it is just a template to be used as a starting point for a
module with actual content. It contains the template for:

* sources (`src` folder)
* includes and templated classes (`include` folder)
* application (`app` folder)
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

The CMakeLists.txt and otb-modules need to be modified with the name of the
module, something along the following:

```
sed 's/ExternalTemplate/MyModule/g' CMakeLists.txt otb-module.cmake
```

There is the inplace option to sed, but it's not portable, so do this change by
hand or look up the option in sed.

Then hack away at you code in include, src, test and app folders.

### License

This software is distributed under the Apache License. Please see LICENSE for
details.

### Author

Manuel Grizonnet

### Thanks

It is a fork of the ITK template module provided by Bradley Lowekamp
(https://github.com/blowekamp/itkExternalTemplate.git) which was adapted for the
ORFEO ToolBox.
