# Copyright 2009, UCAR/Unidata and OPeNDAP, Inc.
# See the COPYRIGHT file for more information.

AUTOMAKE_OPTIONS = foreign
ACLOCAL_AMFLAGS = -I conf

AM_LDFLAGS = 
AM_CFLAGS = -Wall -g -O0

lib_LTLIBRARIES = libbz2.la

include_HEADERS = bzlib.h

libbz2_la_SOURCES =\
      blocksort.c  \
      huffman.c    \
      crctable.c   \
      randtable.c  \
      compress.c   \
      decompress.c \
      bzlib.c

libbz2_la_LDFLAGS = -no-undefined

libbz2_la_CPPFLAGS = -DDLL_EXPORT


CLEANFILES = bzip2dll.def
MAINTAINERCLEANFILES = Makefile.in

EXTRA_DIST = bz-common.xsl bzdiff bzdiff.1 bz-fo.xsl bzgrep \
bzgrep.1 bz-html.xsl bzip.css bzip2.1 bzip2.1.preformatted \
bzip2.txt bzip2-config.cmake.in bzlib_private.h bzmore bzmore.1 \
CHANGES CMakeInstallation.cmake CMakeLists.txt dlltest.dsp entities.xml \
format.pl LICENSE makefile.msc Makefile-libbz2_so manual.html \
manual.pdf manual.ps manual.xml README README.COMPILATION.PROBLEMS \
README.XML.STUFF sample1.bz2 sample1.rb2 sample1.ref sample1.tst \
sample2.bz2 sample2.rb2 sample2.ref sample2.tst sample3.bz2 \
sample3.rb2 sample3.ref sample3.tst tests/ unzcrash.c \
words0 words1 words2 words3 xmlproc.sh
