# Copyright 2009, UCAR/Unidata
# See the COPYRIGHT file for more information.

ACLOCAL_AMFLAGS = -I conf

SUBDIRS =
if BUILD_ZIP
SUBDIRS += zlib
endif
if BUILD_BZIP2
SUBDIRS += bzip2
endif
if BUILD_FPZIP
SUBDIRS += fpzip
endif
if BUILD_ZFP
SUBDIRS += zfp
endif

DISTCLEANFILES = Makefile.in ./configure aclocal.m4 conf/* config.h.in

dist-hook:
	echo "dist/distcheck not supported"
	exit 1

EXTRA_DIST = cmake_uninstall.cmake.in CMakeInstallation.cmake CMakeLists.txt README.md
