set(SOURCES zheevc3.cxx zheevh3.cxx zheevq3.cxx zhetrd3.cxx)
list(TRANSFORM SOURCES REPLACE ".cxx" ".h" OUTPUT_VARIABLE HEADERS)

add_library(MatrixDecomp SHARED ${SOURCES})

target_include_directories(
  MatrixDecomp PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                      $<INSTALL_INTERFACE:include>)

target_link_libraries(MatrixDecomp PUBLIC ROOT::RIO)

set_target_properties(MatrixDecomp PROPERTIES PUBLIC_HEADER "${HEADERS}"
                                              OUTPUT_NAME MatrixDecomp)

add_root_dictionary(MatrixDecomp HEADERS ${HEADERS} LINKDEF LinkDef.h)

install(
  TARGETS MatrixDecomp
  EXPORT oscprob
  PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/MatrixDecomp")
