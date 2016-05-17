
# fpzip CMakeLists.txt file.
#####

SET(fpzip_SOURCES src/error.cpp
  src/rcdecoder.cpp src/rcencoder.cpp src/rcqsmodel.cpp src/read.cpp src/write.cpp)

include_directories(inc)

ADD_DEFINITIONS(-DFPZIP_BLOCK_SIZE=${FPZIP_BLOCK_SIZE})
ADD_DEFINITIONS(-DFPZIP_FP=${FPZIP_FP})
ADD_DEFINITIONS(-DFPZIP_CONV=${FPZIP_CONV})

ADD_LIBRARY(fpzip ${fpzip_SOURCES})

SET_TARGET_PROPERTIES(fpzip PROPERTIES
  VERSION ${fpcomp_LIB_VERSION}
  SOVERSION ${fpcomp_SO_VERSION}
  )


###
# Install the library
###
INSTALL(
  TARGETS fpzip
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    COMPONENT libraries
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    COMPONENT libraries
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    COMPONENT libraries
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  )

###
# Install the header file
###
INSTALL(FILES ${fpzip_SRC_DIR}/inc/fpzip.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  COMPONENT headers)

INSTALL(FILES inc/fpzip.h
	      DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
	      COMPONENT headers)

CONFIGURE_FILE("${CMAKE_CURRENT_SOURCE_DIR}/fpzip-config.cmake.in"
  "${CMAKE_CURRENT_SOURCE_DIR}/fpzip-config.cmake"
  @ONLY)

INSTALL(FILES fpzip-config.cmake
	      DESTINATION ${CMAKE_INSTALL_CMAKEDIR}
	      COMPONENT headers)
