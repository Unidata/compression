#####
# Contains variables and settings used
# by the CMake build system in order to
# build binary installers.
#####

SET(CPACK_PACKAGE_VENDOR "Unidata, Lawrence Livermore")

###
# Create an 'uninstall' target
###
CONFIGURE_FILE(
	"${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
	"${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
	IMMEDIATE @ONLY)

ADD_CUSTOM_TARGET(uninstall
	COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)

INCLUDE(CPack)