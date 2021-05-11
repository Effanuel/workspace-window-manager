#!/usr/bin/env bash

appkit=$(find . -type d -name appkit)

if [[ $appkit ]]; then
    appkit_dir=$(echo $appkit | sed 's/appkit//g')
    AppKit="${appkit_dir}AppKit"

    mv $appkit $AppKit
    echo "Fix applied."
else
    echo "Fix is already applied."
fi