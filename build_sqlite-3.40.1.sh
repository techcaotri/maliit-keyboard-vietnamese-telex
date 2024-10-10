#!/bin/env bash

pushd .
cd sqlite-version-3.40.1
if [ ! -d build ]; then
    mkdir build
fi

cd build
LDFLAGS="-fPIC" CFLAGS="-fPIC" CXXFLAGS="-Wno-narrowing -fPIC" ../configure --enable-static --disable-shared 2>&1 | tee configure_output.log
make -j8 VERBOSE=1 2>&1 | tee make_output.log
sudo make install 2>&1 | tee install_output.txt
