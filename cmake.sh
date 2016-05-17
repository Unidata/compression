#!/bin/sh

PREFIX=/usr/local
INSTALL=0

CPPATH="t:/cygwin/usr/local"

rm -fr build
mkdir build
cd build

FLAGS="-DCMAKE_PREFIX_PATH=${CPPATH}"
FLAGS="$FLAGS -DCMAKE_INSTALL_PREFIX=${PREFIX}"
FLAGS="$FLAGS -DBUILD_SHARED_LIBS=ON"
cmake $FLAGS ..
cmake --build .
CTEST_OUTPUT_ON_FAILURE=1 cmake --build . --target test
#cmake --build . --target install
