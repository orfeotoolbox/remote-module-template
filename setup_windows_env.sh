#!/bin/bash

eval "$(python vcvars_proxy.py 'c:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/Common7/Tools/VsDevCmd.bat' '-arch=amd64' '-host_arch=amd64' '-vcvars_ver=14.0')"

export CC=cl.exe
export CXX=cl.exe
export CC_FOR_BUILD=cl.exe
export CXX_FOR_BUILD=cl.exe
