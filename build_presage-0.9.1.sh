#!/bin/env bash

pushd .
cd presage-0.9.1
if [ ! -d build ]; then
    mkdir build
fi

cd build
LDFLAGS="-fPIC" CXXFLAGS="-Wno-narrowing -fPIC -std=c++14" ../configure --enable-static --disable-shared --disable-gprompter 2>&1 | tee configure_output.log
make -j8 VERBOSE=1 2>&1 | tee make_output.log
sudo make install 2>&1 | tee install_output.txt
