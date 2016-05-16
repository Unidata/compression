# -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.62)
AC_INIT(fpzip, 1.1.0, support@opendap.org)
AC_CONFIG_HEADER([config.h])
AC_CONFIG_AUX_DIR(conf)

AM_INIT_AUTOMAKE([foreign subdir-objects])
AC_CONFIG_MACRO_DIR([conf])
AC_CANONICAL_HOST
AC_SUBST(host)

dnl library versionning: Update these when the interface changes. Generally,
dnl assume that the interface tracks the major and minor release numbers.

# Unfortunately, we can't use AC_SUBST variables in specifying SUBDIRS
# in Makefile.am because autoconf checks for existence before substitution.
# So, these must match Makefile.am
LIBZ_VERSION=1.2.8
LIBBZ2_VERSION=1.0.6
LIBFPZIP_VERSION=1.1.0
LIBZFP_VERSION=0.5.0

AC_SUBST([LIBZ_VERSION])
AC_SUBST([LIBBZ2_VERSION])
AC_SUBST([LIBFPZIP_VERSION])
AC_SUBST([LIBZFP_VERSION])

# Checks for programs.
AC_PROG_CXX
AC_PROG_LIBTOOL
AC_PROG_MAKE_SET
AC_PROG_INSTALL

# Tell lower level makefiles we are building at the fpcomp level
AM_CONDITIONAL(BUILD_FPCOMP, [test xyes = xyes])

##################################################
# Checks for additional library functions.
case "$host_os" in
*aix*);;
*)
AC_FUNC_MALLOC
AC_FUNC_ALLOCA
;;
esac
AC_FUNC_VPRINTF
AC_CHECK_FUNCS([memset memmove strcasecmp strchr strrchr strdup strerror strtol access unlink mkstemp getpid strndup strncpy])

##################################################
# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([malloc.h memory.h stddef.h stdlib.h string.h strings.h unistd.h stdarg.h])

##################################################
# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_HEADER_STDBOOL
AC_TYPE_LONG_LONG_INT
AC_TYPE_SIZE_T
AC_TYPE_OFF_T
AC_CHECK_TYPES([ssize_t, ptrdiff_t, uchar])
AC_C_CHAR_UNSIGNED
AC_C_BIGENDIAN
AC_CHECK_SIZEOF(long)
sleep 20
AC_CHECK_SIZEOF(size_t)
sleep 20
AC_CHECK_SIZEOF(off_t)
sleep 20
AC_CHECK_SIZEOF(void*)

##################################################
#which compression filters to enable

AC_MSG_CHECKING([build all compressors])
AC_ARG_ENABLE([all],
    [AS_HELP_STRING([--enable-all],[Build all compression libraries.])])
test "x$enable_all" = xno || enable_all=yes
AC_MSG_RESULT([$enable_all])
if test "x$enable_all" = xyes ; then
enable_zip=yes
enable_bzip2=yes
enable_fpzip=yes
enable_zfp=yes
fi

AC_MSG_CHECKING([build zip library])
AC_ARG_ENABLE([zip],
    [AS_HELP_STRING([--enable-zip],[Build zip library.])])
test "x$enable_zip" = xyes || enable_zip=no
AC_MSG_RESULT([$enable_zip])

AC_MSG_CHECKING([build bzip2 library])
AC_ARG_ENABLE([bzip2],
    [AS_HELP_STRING([--enable-bzip2],[Build bzip2 library.])])
test "x$enable_bzip2" = xyes || enable_bzip2=no
AC_MSG_RESULT([$enable_bzip2])

AC_MSG_CHECKING([build fpzip library])
AC_ARG_ENABLE([fpzip],
    [AS_HELP_STRING([--enable-fpzip],[Build fpzip library.])])
test "x$enable_fpzip" = xyes || enable_fpzip=no
AC_MSG_RESULT([$enable_fpzip])

AC_MSG_CHECKING([build zfp library])
AC_ARG_ENABLE([zfp],
    [AS_HELP_STRING([--enable-zfp],[Build zfp library.])])
test "x$enable_zfp" = xyes || enable_zfp=no
AC_MSG_RESULT([$enable_zfp])

if test "x$enable_zip" = xyes ; then
AC_DEFINE([BUILD_ZIP], [1], [if true, build zip library])
fi
AM_CONDITIONAL(BUILD_ZIP, [test x$enable_zip = xyes])
if test "x$enable_bzip2" = xyes ; then
AC_DEFINE([BUILD_BZIP2], [1], [if true, build bzip2 library])
fi
AM_CONDITIONAL(BUILD_BZIP2, [test x$enable_bzip2 = xyes])
if test "x$enable_fpzip" = xyes ; then
AC_DEFINE([BUILD_FPZIP], [1], [if true, build fpzip library])
fi
AM_CONDITIONAL(BUILD_FPZIP, [test x$enable_fpzip = xyes])
if test "x$enable_zfp" = xyes ; then
AC_DEFINE([BUILD_ZFP], [1], [if true, build zfp library])
fi
AM_CONDITIONAL(BUILD_ZFP, [test x$enable_zfp = xyes])

##################################################
# FPZIP Options

AC_MSG_CHECKING([fpzip Compression optimization])
AC_ARG_WITH([opt],
              [AS_HELP_STRING([--with-opt=FAST|SAFE|EMUL|INT],
                              [Compression optimization])],
              [FP=$with_opt],
              [FP=FAST])
FPZIP_FP=FPZIP_FP_$FP
AC_MSG_RESULT([${FP}])
AC_DEFINE_UNQUOTED([FPZIP_FP], $FPZIP_FP, [fpzip compression optimization])

AC_MSG_CHECKING([fpzip output buffer size])
AC_ARG_WITH([output-buffer-size],
              [AS_HELP_STRING([--with-output-buffer-size=<int>],
                              [Output Buffer Size (ideally the disk block size)])],
              [FPZIP_BLOCK_SIZE=$with_output_buffer_size],
              [FPZIP_BLOCK_SIZE=0x1000])
AC_MSG_RESULT([$FPZIP_BLOCK_SIZE])
AC_DEFINE_UNQUOTED([FPZIP_BLOCK_SIZE], [$FPZIP_BLOCK_SIZE], [fpzip Output buffer size])

AC_MSG_CHECKING([fpzip Bitwise type conversion mechanism])
AC_ARG_WITH([convert],
              [AS_HELP_STRING([--with-convert=UNION|CAST],
                              [Bitwise type conversion mechanism])],
	      [],
              [with_convert=UNION])
AC_MSG_RESULT([$with_convert])
if test "x$with_convert" = xUNION ; then
AC_DEFINE([WITH_UNION], [1], [Bitwise type conversion mechanism])
fi
if test "x$with_fpzip_convert" = xCAST ; then
AC_DEFINE([WITH_REINTERPRET_CAST], [1], [Bitwise type conversion mechanism])
fi

# Modify fpzip/inc/codec.h to include config.h
FPZIPDIR="fpzip"
FPCODEC_H="${FPZIPDIR}/inc/codec.h"
if test -f ${FPCODEC_H} ; then 
  if test ! -f ${FPCODEC_H}.save ; then   
    AC_MSG_NOTICE([backup inc/codec.h])      
    cp ${FPCODEC_H} ${FPCODEC_H}.save
    ls -l ${FPCODEC_H}.save
  fi
  AC_MSG_NOTICE([fpzip modifying inc/codec.h to reference config.h])      
  rm -f ${FPCODEC_H}
  echo '#include "config.h"' > ${FPCODEC_H}
  cat ${FPCODEC_H}.save >> ${FPCODEC_H}
else
  AC_MSG_ERROR([fpzip has changed; inc/codec.h does not exist])
fi

if test 0 = 1 ; then
# Modify zfp/inc/zfp.h and zfp/inc/bitstream.h
ZFPDIR="zfp"
ZFP_H="${ZFPDIR}/inc/zfp.h"
BSTR_H="${ZFPDIR}/inc/bitstream.h"
if test -f ${ZFP_H} -a -f ${BSTR_H} ; then 
  if test ! -f ${ZFP_H}.save ; then cp ${ZFP_H} ${ZFP_H}.save ;  fi
  if test ! -f ${BSTR_H}.save ; then cp ${BSTR_H} ${BSTR_H}.save ;  fi
  AC_MSG_NOTICE([zfp modifying inc/zfp.h and bitstream.h])
  rm -f ${ZFP_H} ${BSTR_H}
  sed -e '/#include "types.h"/d' <${BSTR_H}.save >${BSTR_H}
  sed -e '/#include "types.h"/d' -e '/#include "system.h"/d' <${ZFP_H}.save >${ZFP_H}
else
  AC_MSG_ERROR([zfp has changed; inc/codec.h does not exist])
fi
fi

##################################################
dnl autoheader macros; tack some text at the top and bottom of config_dap.h.in

AH_BOTTOM(
[/* Define strcasecmp, snprintf on Win32 systems. */
#ifdef _WIN32
#define strcasecmp _stricmp
#define snprintf _snprintf
#endif])

##################################################
# Process the Makefile.am (and other) files
AC_CONFIG_FILES([Makefile
                 fpzip/Makefile
                 zfp/Makefile
                 bzip2/Makefile
                 zlib/Makefile ])
AC_OUTPUT

##################################################

echo "ZIP Enabled = $enable_zip"
echo "BZIP2 Enabled = $enable_bzip2"
echo "FPZIP Enabled = $enable_fpzip"
echo "ZFP Enabled = $enable_zfp"
