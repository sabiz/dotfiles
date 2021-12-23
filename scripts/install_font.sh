#!/bin/bash -eu

if [ $OS = 'Linux' ];then
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    curl -OL https://github.com/yuru7/HackGen/releases/download/${1}/HackGenNerd_${1}.zip
    unzip -o HackGenNerd_${1}.zip
    rm -rf HackGenNerd_${1}.zip


    if type fc-cache > /dev/null 2>&1; then
        fc-cache -f -v
    fi
fi
