#!/bin/bash
# Provide the zfp and fpzip libraries
FPZIP=fpzip-1.1.0.tar.gz
ZFP=zfp-0.4.0.tar.gz

for var in "$@"  ; do
case "$var" in
fpzip*) FPZIP="$var";;
zfp*) ZFP="$var";;
*) echo "expected zfp... or fpzip..."; exit;;
esac
done

ZFPLIB=`echo $ZFP | cut -d . -f -3`
ZFPVER=`echo $ZFPLIB | cut -d - -f2`
ZFPLIBVER=`echo $ZFPVER | tr '.' ':'`
FPZLIB=`echo $FPZIP | cut -d . -f -3`
FPZVER=`echo $FPZLIB | cut -d - -f2`
FPZLIBVER=`echo $FPZVER | tr '.' ':'`

rm -fr $ZFPLIB
tar -zxf $ZFP
rm -fr $FPZLIB
tar -zxf $FPZIP

cat configure.ac.in \
| sed -e  "s|FPZLIB|$FPZLIB|g" -e "s|FPZVER|$FPZVER|g" \
| sed -e  "s|ZFPLIB|$ZFPLIB|g" -e "s|ZFPVER|$ZFPVER|g" \
| cat > configure.ac.new

cat Makefile.am.in \
| sed -e  "s|FPZLIB|$FPZLIB|g" \
| sed -e  "s|ZFPLIB|$ZFPLIB|g" \
| cat > Makefile.am.new

cp templates/CMakeLists.txt.fpzip $FPZLIB/CMakeLists.txt
cp templates/fpzip-config.cmake.in $FPZLIB
cp templates/Makefile.am.fpzip $FPZLIB/Makefile.am

cp templates/CMakeLists.txt.zfp $ZFPLIB/CMakeLists.txt
cp templates/zfp-config.cmake.in $ZFPLIB
cp templates/Makefile.am.zfp $ZFPLIB/Makefile.am

rm -fr Makefile.am configure.ac
mv Makefile.am.new  Makefile.am
mv configure.ac.new  configure.ac
exit
