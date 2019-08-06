cmake_minimum_required(VERSION 2.8.9)
project(ExternalTemplate)

set(ExternalTemplate_LIBRARIES ExternalTemplate)

if(NOT OTB_SOURCE_DIR)
  find_package(OTB REQUIRED)
  list(APPEND CMAKE_MODULE_PATH ${OTB_CMAKE_DIR})
  include(UseOTB)
  set(Python_ADDITIONAL_VERSIONS "3")
  find_package( PythonInterp REQUIRED)
  include(OTBModuleExternal)
else()
  otb_module_impl()
endif()

