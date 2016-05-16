# Copyright 2009, UCAR/Unidata and OPeNDAP, Inc.
# See the COPYRIGHT file for more information.

AUTOMAKE_OPTIONS = foreign
ACLOCAL_AMFLAGS = -I conf

AM_LDFLAGS = 
AM_CFLAGS = -Wall -g -O0 -D_LARGEFILE64_SOURCE=1 -DHAVE_HIDDEN

lib_LTLIBRARIES = libz.la

include_HEADERS = src/zlib.h

SRC=\
src/adler32.c \
src/crc32.c \
src/deflate.c \
src/infback.c \
src/inffast.c \
src/inflate.c \
src/inftrees.c \
src/trees.c \
src/zutil.c \
src/compress.c \
src/uncompr.c \
src/gzclose.c \
src/gzlib.c \
src/gzread.c \
src/gzwrite.c

HDRS=\
src/crc32.h \
src/deflate.h \
src/gzguts.h \
src/inffast.h \
src/inffixed.h \
src/inflate.h \
src/inftrees.h \
src/trees.h \
src/zconf.h \
src/zlib.h \
src/zutil.h

libz_la_SOURCES = ${SRC} ${HDRS}

libz_la_LDFLAGS = -no-undefined

libz_la_CPPFLAGS = -DDLL_EXPORT

CLEANFILES = 
MAINTAINERCLEANFILES = Makefile.in

EXTRA_DIST = 
