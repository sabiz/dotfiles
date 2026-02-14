#!/bin/bash -eu

if [ $OS = 'Linux' ];then
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    curl -OL https://github.com/yuru7/HackGen/releases/download/${1}/HackGen_NF_${1}.zip
    unzip -o HackGen_NF_${1}.zip
    rm -rf HackGen_NF_${1}.zip


    if type fc-cache > /dev/null 2>&1; then
        fc-cache -f -v
    fi
elif [ $OS = 'Mac' ];then
    mkdir -p ~/Library/Fonts
    cd ~/Library/Fonts
    curl -OL https://github.com/yuru7/HackGen/releases/download/${1}/HackGen_NF_${1}.zip
    unzip -o -j HackGen_NF_${1}.zip '*.ttf'
    rm -rf HackGen_NF_${1}.zip
fi
