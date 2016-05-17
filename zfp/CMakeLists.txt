#####
# zfp CMakeLists.txt file.
#####

SET(zfp_SOURCES src/zfp.c src/bitstream.c
src/decode1d.c src/decode1f.c src/decode2d.c
src/decode2f.c src/decode3d.c src/decode3f.c
src/encode1d.c src/encode1f.c src/encode2d.c
src/encode2f.c src/encode3d.c src/encode3f.c)

include_directories(inc)

ADD_LIBRARY(zfp ${zfp_SOURCES})

SET_TARGET_PROPERTIES(zfp PROPERTIES
  VERSION ${fpcomp_LIB_VERSION}
  SOVERSION ${fpcomp_SO_VERSION}
  )

###
# Install the library
###
INSTALL(
  TARGETS zfp
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
INSTALL(FILES ${zfp_SRC_DIR}/inc/zfp.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  COMPONENT headers)

INSTALL(FILES inc/zfp.h
	      DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
	      COMPONENT headers)

CONFIGURE_FILE("${CMAKE_CURRENT_SOURCE_DIR}/zfp-config.cmake.in"
  "${CMAKE_CURRENT_SOURCE_DIR}/zfp-config.cmake"
  @ONLY)

INSTALL(FILES zfp-config.cmake
	      DESTINATION ${CMAKE_INSTALL_CMAKEDIR}
	      COMPONENT headers)

#ADD_SUBDIRECTORY(src)
