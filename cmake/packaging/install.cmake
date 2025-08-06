include_guard()

set(PREMDIR ${CMAKE_INSTALL_PREFIX}/PremTables)
set(MODEL3DDIR ${CMAKE_INSTALL_PREFIX}/EarthTables)
set(PREMFILE ${PREMDIR}/prem_default.txt)
set(PREM3DFILE ${MODEL3DDIR}/earth_binned_default.txt)

configure_file(
  ${CMAKE_CURRENT_LIST_DIR}/prem_default.hpp.in
  ${CMAKE_BINARY_DIR}/prem_default.hpp @ONLY USE_SOURCE_PERMISSIONS)

install(DIRECTORY ${PROJECT_SOURCE_DIR}/PremTables
        DESTINATION ${CMAKE_INSTALL_PREFIX})

install(DIRECTORY ${PROJECT_SOURCE_DIR}/EarthTables
        DESTINATION ${CMAKE_INSTALL_PREFIX})

install(
  EXPORT oscprob
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
  NAMESPACE OscProb::)

install(FILES ${CMAKE_CURRENT_LIST_DIR}/oscprob-config.cmake
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

install(FILES ${CMAKE_CURRENT_LIST_DIR}/oscprob-eigen3.cmake
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})
