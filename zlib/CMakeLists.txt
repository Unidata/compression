#####
# Pass-through to src.
#####

INCLUDE_DIRECTORIES(inc)

INSTALL(FILES src/zlib.h
	      DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
	      COMPONENT headers)

CONFIGURE_FILE("${CMAKE_CURRENT_SOURCE_DIR}/zlib-config.cmake.in"
  "${CMAKE_CURRENT_SOURCE_DIR}/zlib-config.cmake"
  @ONLY)

INSTALL(FILES zlib-config.cmake
	      DESTINATION ${CMAKE_INSTALL_CMAKEDIR}
	      COMPONENT headers)

