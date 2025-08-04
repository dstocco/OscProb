cmake_minimum_required(VERSION 3.16)
project(oscprob LANGUAGES CXX)

include(GNUInstallDirs)

# Instructions to properly handle RPATH
if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
      ${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})
endif()
if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY
      ${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
endif()
if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY
      ${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
endif()

#
# Define our RPATH settings, for both build and install phases
#

# use, i.e. do not skip, the full RPATH in the _build_ tree
set(CMAKE_SKIP_BUILD_RPATH FALSE)

# when building, do not use the install RPATH already (will only be used when
# actually installing)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)

# add to the install RPATH the (automatically determined) parts of the RPATH
# that point to directories outside the build tree
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

# specify libraries directory relative to binaries one.
file(RELATIVE_PATH relDir ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
     ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})

if(APPLE)
  set(basePoint @loader_path)
else()
  set(basePoint $ORIGIN)
endif()

set(CMAKE_INSTALL_RPATH ${basePoint} ${basePoint}/${relDir}
                        ${basePoint}/../../lib)

include(dependencies.cmake)

# useful functions to ease declaration of libraries and executables for this
# project
include(cmake/functions/CMakeLists.txt)

# Define SOURCES
set(SOURCES
    src/Absorption.cxx
    src/EarthModelBase.cxx
    src/EarthModelBinned.cxx
    src/EigenPoint.cxx
    src/NuPath.cxx
    src/PMNS_Base.cxx
    src/PMNS_Decay.cxx
    src/PMNS_Deco.cxx
    src/PMNS_Fast.cxx
    src/PMNS_Iter.cxx
    src/PMNS_LIV.cxx
    src/PMNS_NSI.cxx
    src/PMNS_NUNM.cxx
    src/PMNS_SNSI.cxx
    src/PMNS_Sterile.cxx
    src/PremModel.cxx
    src/complexsolver.cxx)

# Define headers from sources
list(TRANSFORM SOURCES REPLACE "src/" "inc/" OUTPUT_VARIABLE HEADERS)
list(TRANSFORM HEADERS REPLACE ".cxx" ".h")
list(APPEND HEADERS "inc/Definitions.h" "${CMAKE_BINARY_DIR}/prem_default.hpp")

# Add library
add_library(OscProb SHARED ${SOURCES})

# Add include directories
list(APPEND includePath ${CMAKE_CURRENT_SOURCE_DIR}
     ${CMAKE_CURRENT_SOURCE_DIR}/inc ${CMAKE_BINARY_DIR})
foreach(incDir IN LISTS includePath)
  target_include_directories(OscProb PUBLIC $<BUILD_INTERFACE:${incDir}>
                                            $<INSTALL_INTERFACE:include>)
endforeach()

# Link libraries
target_link_libraries(
  OscProb
  PRIVATE MatrixDecomp
  PUBLIC ROOT::RIO Eigen3::Eigen)

set_target_properties(OscProb PROPERTIES PUBLIC_HEADER "${HEADERS}" OUTPUT_NAME
                                                                    OscProb)
add_root_dictionary(OscProb HEADERS ${HEADERS} LINKDEF inc/LinkDef.h)

install(
  TARGETS OscProb
  EXPORT oscprob
  PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")

add_subdirectory(MatrixDecomp)

if(PROJECT_IS_TOP_LEVEL)
  include(cmake/packaging/CMakeLists.txt)
endif()
