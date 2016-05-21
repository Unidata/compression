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

# Tell lower level makefiles we are building at the top level
AM_CONDITIONAL(BUILD_COMPRESSION, [test xyes = xyes])

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
# Check for compression algorithms to enable.
# The algorithm operates as follows.
# 1. A specific set of filters is defined by --with-compression=<comma list of filters>
# 2. Using the 'all' keyword (e.g. --with-compression=all)
#    is equivalent to --with-compression=$DFALTFILTERS

# Set of all known filters; must match arms of the case...esac below
ALLFILTERS="zlib,bzip2,fpzip,zfp"
# Set of filters turned on by default 
DFALTFILTERS="bzip2,fpzip,zfp"

AC_MSG_CHECKING([which specific compression filters to enable])
AC_ARG_WITH([compression],
              [AS_HELP_STRING([--with-compression=filter,filter,...|all],
                              [Specify filters to look for.])],
              [WITHFILTERS=$with_compression],
              [WITHFILTERS="all"])
AC_MSG_RESULT([$WITHFILTERS])

# Does the user want all filters?
if test "x$WITHFILTERS" = xall ; then
  WITHFILTERS="$DFALTFILTERS"
fi

# Figure out final set of enabled filters
if test "x$WITHFILTERS" != x ; then
  ENABLEDFILTERS="$WITHFILTERS"
fi

# Set specific filter flags
ENABLEDFILTERS=`echo $ENABLEDFILTERS | tr ',' ' '`
# Iterate over enabled filters
ACTIVEFILTERS=""      
for f in ${ENABLEDFILTERS} ; do
      # Lower-case the filter name
      flc=`echo $f | tr ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz`
      DUP=0
      for a in ${ACTIVEFILTERS} ; do
        if test "x$a" = "x${flc}" ; then DUP=1; break; fi
      done
      if test $DUP = 1 ; then continue; fi
      case "${flc}" in
      zip)
        AC_DEFINE([ZIP_FILTER], [1], [if true, compile zip compression])
	enable_zip=yes
	;;

      szip)
        AC_DEFINE([SZIP_FILTER], [1], [if true, compile szip compression])
	enable_szip=yes
        ;;

      bzip2)
        AC_DEFINE([BZIP2_FILTER], [1], [if true, compile bzip2 compression])
	enable_bzip2=yes
        ;;

      fpzip)
        AC_DEFINE([FPZIP_FILTER], [1], [if true, compile fpzip compression])
	enable_fpzip=yes
        ;;

      zfp)
        AC_DEFINE([ZFP_FILTER], [1], [if true, compile zfp compression])
	enable_zfp=yes
        ;;
      *) AC_MSG_NOTICE([Unknown filter: ${flc} ; ignored])
         ;;
      esac
      ACTIVEFILTERS="${ACTIVEFILTERS} ${flc}"
      AC_MSG_NOTICE([${flc} library activated])
 done
AC_MSG_NOTICE([Available and enabled filters=$ACTIVEFILTERS"])
if test "x$ACTIVEFILTERS" != x ; then
  AC_DEFINE([ENABLE_FILTERS], [1], [if true, support zfp compression])
fi

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
#AC_DEFINE_UNQUOTED([FPZIP_FP], $FPZIP_FP, [fpzip compression optimization])
AC_SUBST([FPZIP_FP], $FPZIP_FP)

AC_MSG_CHECKING([fpzip output buffer size])
AC_ARG_WITH([output-buffer-size],
              [AS_HELP_STRING([--with-output-buffer-size=<int>],
                              [Output Buffer Size (ideally the disk block size)])],
              [FPZIP_BLOCK_SIZE=$with_output_buffer_size],
              [FPZIP_BLOCK_SIZE=0x1000])
AC_MSG_RESULT([$FPZIP_BLOCK_SIZE])
#AC_DEFINE_UNQUOTED([FPZIP_BLOCK_SIZE], [$FPZIP_BLOCK_SIZE], [fpzip Output buffer size])
AC_SUBST([FPZIP_BLOCK_SIZE], [$FPZIP_BLOCK_SIZE])

AC_MSG_CHECKING([fpzip Bitwise type conversion mechanism])
AC_ARG_WITH([convert],
              [AS_HELP_STRING([--with-convert=UNION|CAST],
                              [Bitwise type conversion mechanism])],
	      [],
              [with_convert=UNION])
AC_MSG_RESULT([$with_convert])
AM_CONDITIONAL([WITH_UNION], [test x$with_convert = xUNION])
AM_CONDITIONAL([WITH_REINTERPRET_CAST], [test x$with_convert = xCAST])

if test 0 = 1 ; then
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
