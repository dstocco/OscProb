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
    GIT_REPOSITORY https://gitlab.com/libeigen/eigen.git
    GIT_TAG 3147391d946bb4b6c68edd901f2add6ac1f31f8c
    GIT_SHALLOW TRUE
    GIT_PROGRESS TRUE
    EXCLUDE_FROM_ALL)
  FetchContent_MakeAvailable(Eigen3)
endif()
