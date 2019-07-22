
# This script is a prototype for the future CI, it may evolve rapidly in a near future
set(REMOTE_MODULE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR})
set (ENV{LANG} "C") # Only ascii output

# Build Configuration : Release, Debug..
if(ci_build_type)
  set (CTEST_BUILD_CONFIGURATION ${ci_build_type})
else()
  set (CTEST_BUILD_CONFIGURATION "Release")
endif()

set (CTEST_CMAKE_GENERATOR "Ninja")

# detect short sha
if(NOT DEFINED ENV{TRAVIS_COMMIT})
  execute_process(COMMAND git log -1 --pretty=format:%h
                  WORKING_DIRECTORY ${REMOTE_MODULE_SOURCE_DIR}
                  OUTPUT_VARIABLE ci_short_sha)
else()
  set(ci_short_sha "$ENV{TRAVIS_COMMIT}")
endif()

set(CTEST_BUILD_NAME "$ENV{TRAVIS_BRANCH}")
set(CTEST_SITE "ubuntu-$ENV{TRAVIS_DIST}-$ENV{TRAVIS_COMPILER}")


# Detect "skip testing"
if(DEFINED ENV{CI_SKIP_TESTING})
  set(ci_skip_testing 1)
endif()

# Directory variable
set (CTEST_SOURCE_DIRECTORY "${REMOTE_MODULE_SOURCE_DIR}")
if(BUILD_DIR)
  set (CTEST_BINARY_DIRECTORY "${BUILD_DIR}")
else()
  set (CTEST_BINARY_DIRECTORY "${REMOTE_MODULE_SOURCE_DIR}/build/")
endif()
if(INSTALL_DIR)
  set (CTEST_INSTALL_DIRECTORY "${INSTALL_DIR}")
else()
  set (CTEST_INSTALL_DIRECTORY "${REMOTE_MODULE_SOURCE_DIR}/install/")
endif()
set (PROJECT_SOURCE_DIR "${REMOTE_MODULE_SOURCE_DIR}")

# Ctest command value
set (CMAKE_COMMAND "cmake")

#The following file set the CONFIGURE_OPTIONS variable

set (CONFIGURE_OPTIONS
"-DBUILD_SHARED_LIBS:BOOL=ON
-DBUILD_TESTING:BOOL=ON
-DOTB_BUILD_MODULE_AS_STANDALONE:BOOL=ON
-DCMAKE_PREFIX_PATH:PATH=${REMOTE_MODULE_SOURCE_DIR}/xdk
-DCMAKE_INSTALL_PREFIX:PATH=${CTEST_INSTALL_DIRECTORY}
-DCMAKE_BUILD_TYPE=${CTEST_BUILD_CONFIGURATION}
")

# Sources are already checked out : do nothing for update
set(CTEST_GIT_UPDATE_CUSTOM "${CMAKE_COMMAND}" "-E" "echo" "No update")

# Look for a GIT command-line client.
find_program(CTEST_GIT_COMMAND NAMES git git.cmd)

# End of configuration

ctest_start (Experimental TRACK RemoteModules)

ctest_update()

# --------------------------- Configure ----------------------------------------
ctest_configure(BUILD "${CTEST_BINARY_DIRECTORY}"
    SOURCE "${REMOTE_MODULE_SOURCE_DIR}"
    OPTIONS "${CONFIGURE_OPTIONS}"
    RETURN_VALUE _configure_rv
    CAPTURE_CMAKE_ERROR _configure_error
    )
# Configure log
file ( WRITE 
  "${REMOTE_MODULE_SOURCE_DIR}/log/configure_return_value_log.txt" "${_configure_rv}")
file ( WRITE 
  "${REMOTE_MODULE_SOURCE_DIR}/log/configure_cmake_error_log.txt" "${_configure_error}")

if ( NOT _configure_rv EQUAL 0 )
  # stop processing here
  ctest_submit()
  message( FATAL_ERROR "An error occurs during ctest_configure.")
endif()

# ------------------------------ Build -----------------------------------------
if(ci_skip_install)
  message(STATUS "Skip install")
  if (ci_build_target)
    message(STATUS "Building target: ${ci_build_target}")
    set(CTEST_BUILD_TARGET ${ci_build_target})
  else()
    set(CTEST_BUILD_TARGET)
  endif()
else()
  set(CTEST_BUILD_TARGET install)
endif()

ctest_build(BUILD "${CTEST_BINARY_DIRECTORY}"
            RETURN_VALUE _build_rv
            CAPTURE_CMAKE_ERROR _build_error
            )
# Build log
file ( WRITE 
  "${REMOTE_MODULE_SOURCE_DIR}/log/build_return_value_log.txt" "${_build_rv}")
file ( WRITE 
  "${REMOTE_MODULE_SOURCE_DIR}/log/build_cmake_error_log.txt" "${_build_error}")

if ( NOT _build_rv EQUAL 0 )
  message( SEND_ERROR "An error occurs during ctest_build.")
endif()

# ----------------------------- Test -------------------------------------------
if(ci_skip_testing)
  message(STATUS "Skip testing")
  set(_test_rv 0)
else()
  ctest_test(PARALLEL_LEVEL 2
             RETURN_VALUE _test_rv
             CAPTURE_CMAKE_ERROR _test_error
             )
  # Test log
  file ( WRITE 
    "${REMOTE_MODULE_SOURCE_DIR}/log/test_return_value_log.txt" "${_test_rv}")
  file ( WRITE 
    "${REMOTE_MODULE_SOURCE_DIR}/log/test_cmake_error_log.txt" "${_test_error}")
endif()

if ( NOT _test_rv EQUAL 0 )
  message( SEND_ERROR "An error occurs during ctest_test.")
endif()

# ----------------------------- Submit -----------------------------------------
if(ci_skip_submit)
  message(STATUS "Skip submit")
else()
  ctest_submit()
endif()
