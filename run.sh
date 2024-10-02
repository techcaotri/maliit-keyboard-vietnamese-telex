#!/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/tripham/Qt/5.15.2/gcc_64/lib:$SCRIPT_DIR/keyboard_install/lib/maliit/plugins:$SCRIPT_DIR/../framework/framework_install/lib
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
export GSETTINGS_SCHEMA_DIR="$SCRIPT_DIR/keyboard_install/share/glib-2.0/schemas:${GSETTINGS_SCHEMA_DIR}"
echo "GSETTINGS_SCHEMA_DIR: $GSETTINGS_SCHEMA_DIR"
export XDG_DATA_DIRS="$SCRIPT_DIR/keyboard_install/share/:${XDG_DATA_DIRS}"
echo "XDG_DATA_DIRS: $XDG_DATA_DIRS"
export QT_IM_MODULE=maliit
export MALIIT_FORCE_DBUS_CONNECTION=1
export MALIIT_DEBUG=1

pushd .
cd keyboard_install
./bin/maliit-keyboard

