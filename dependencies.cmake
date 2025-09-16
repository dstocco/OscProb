include_guard()

include(FetchContent)

# ROOT
find_package(ROOT REQUIRED COMPONENTS Core RIO)

find_package(Eigen3 QUIET)
if(NOT TARGET Eigen3::Eigen)
  set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)
  set(EIGEN_BUILD_TESTING OFF)
  set(EIGEN_BUILD_PKGCONFIG OFF)
  set(EIGEN_BUILD_DOC OFF)
  FetchContent_Declare(
    Eigen3
    URL https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.gz
        EXCLUDE_FROM_ALL)
  FetchContent_MakeAvailable(Eigen3)
endif()
