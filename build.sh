#!/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
export CMAKE_PREFIX_PATH=/home/tripham/Qt/qt6-7-3_install
export MaliitPlugins_DIR=$SCRIPT_DIR/../framework/framework_install/lib/cmake/MaliitPlugins/
echo $MaliitPlugins_DIR

if [ ! -d build ]; then
    mkdir build
fi

cd build
script -qec "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_INSTALL_PREFIX=$(pwd)/../keyboard_install/ .. 2>&1" /dev/null | tee cmake_output.txt
script -qec "cmake --build . --config Debug --verbose 2>&1" /dev/null | tee build_output.txt
script -qec "cmake --install . --prefix $(pwd)/../keyboard_install --verbose 2>&1" /dev/null | tee install_output.txt
