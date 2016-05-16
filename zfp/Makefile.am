# Copyright 2009, UCAR/Unidata
# See the COPYRIGHT file for more information.

AUTOMAKE_OPTIONS = foreign
ACLOCAL_AMFLAGS = -I conf 

AM_LDFLAGS = 
AM_CFLAGS = -I./inc

lib_LTLIBRARIES = libzfp.la

libzfp_la_SOURCES = \
src/zfp.c src/bitstream.c \
src/decode1d.c src/decode1f.c src/decode2d.c \
src/decode2f.c src/decode3d.c src/decode3f.c \
src/encode1d.c src/encode1f.c src/encode2d.c \
src/encode2f.c src/encode3d.c src/encode3f.c \
inc/bitstream.h inc/macros.h inc/system.h inc/types.h inc/zfp.h

include_HEADERS = inc/zfp.h inc/types.h inc/system.h inc/bitstream.h

libzfp_la_LDFLAGS = -no-undefined
libzfp_la_CPPFLAGS = -DDLL_EXPORT

EXTRA_DIST = API CMakeLists.txt Config LICENSE README VERSIONS zfp-config.cmake.in

CLEANFILES = zfpdll.def
MAINTAINERCLEANFILES = Makefile.in

