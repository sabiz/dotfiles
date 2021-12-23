#!/bin/bash -eu
if [ "$(uname)" == 'Darwin' ];then
    echo -n 'Mac'
    exit 0
else
    if type "cmd.exe" > /dev/null 2>&1; then
        echo 'Linux_WSL'
        exit 0
    fi
    echo 'Linux'
    exit 0
fi

