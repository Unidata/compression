# Copyright 2009, UCAR/Unidata and OPeNDAP, Inc.
# See the COPYRIGHT file for more information.

AUTOMAKE_OPTIONS = foreign

ACLOCAL_AMFLAGS = -Iconf

AM_LDFLAGS = 
AM_CXXFLAGS = -Wall

AM_CXXFLAGS =  -Iinc -Isrc

AM_CXXFLAGS += -DFPZIP_FP=@FPZIP_FP@
if WITH_UNION
AM_CXXFLAGS += -DWITH_UNION
endif
if WITH_REINTERPRET_CAST
AM_CXXFLAGS += -DWITH_REINTERPRET_CAST
endif

#SUBDIRS = .

lib_LTLIBRARIES = libfpzip.la

libfpzip_la_SOURCES = \
src/error.cpp src/rcdecoder.cpp src/rcencoder.cpp src/rcqsmodel.cpp \
src/read.cpp src/write.cpp \
inc/codec.h inc/fpe.h inc/fpzip.h inc/front.h \
inc/pccodec.h inc/pcdecoder.h inc/pcencoder.h inc/pcmap.h \
inc/rcdecoder.h inc/rcencoder.h inc/rcmodel.h inc/rcqsmodel.h \
inc/read.h inc/write.h \
inc/fpe.inl inc/pccodec.inl inc/pcdecoder.inl inc/pcencoder.inl \
inc/pcmap.inl inc/rcdecoder.inl inc/rcencoder.inl inc/rcqsmodel.inl

include_HEADERS = inc/fpzip.h

libfpzip_la_LDFLAGS = -no-undefined
libfpzip_la_CPPFLAGS = -DDLL_EXPORT

CLEANFILES = fpzipdll.def
MAINTAINERCLEANFILES = Makefile.in

EXTRA_DIST = CMakeLists.txt fpzip-config.cmake.in LICENSING README

