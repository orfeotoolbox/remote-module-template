#!/bin/bash

export PATH='/c/Python37:/c/ProgramData/chocolatey/lib/ninja/tools:${PATH}'

which python

eval "$(python -c '
import sys, os, subprocess
import distutils.msvc9compiler as msvc
msvc.find_vcvarsall=lambda _: sys.argv[1]
envs=msvc.query_vcvarsall(sys.argv[2])
for k,v in envs.items():
    k = k.upper()
    v = ":".join(subprocess.check_output(["cygpath","-u",p]).decode("utf-8").rstrip(" \n") for p in v.split(";"))
    v = v.replace("'\''",r"'\'\\\'\''")
    print("export %(k)s='\''%(v)s'\''" % locals())
' 'c:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/Common7/Tools/VsDevCmd.bat' '-arch=amd64'
)"

export CC=cl.exe
export CXX=cl.exe
export CC_FOR_BUILD=cl.exe
export CXX_FOR_BUILD=cl.exe
