#!/bin/sh

PREFIX=t:/cygwin/tmp/fpcomp
INSTALL=0
case "$1" in
install*)
  PREFIX=t:/cygwin/usr/local
  ;;
*)
  rm -fr /tmp/fpcomp
  mkdir -p /tmp/fpcomp
  ;;
esac

CPPATH="t:/cygwin/usr/local"

rm -fr build
mkdir build
cd build

FLAGS="-DCMAKE_PREFIX_PATH=${CPPATH}"
FLAGS="$FLAGS -DCMAKE_INSTALL_PREFIX=${PREFIX}"
FLAGS="$FLAGS -DBUILD_SHARED_LIBS=ON"
cmake $FLAGS ..
cmake --build .
cmake --build . --target install
