#!/bin/bash -eu

INSTALLER_VERSION='v0.5.0'
ESC=$(printf '\033')

echo -e "
${ESC}[38;2;52;148;230m  ██████╗  ██████╗ ████████╗    ███████╗██╗██╗     ███████╗███████╗     
${ESC}[38;2;68;144;224m  ██╔══██╗██╔═══██╗╚══██╔══╝    ██╔════╝██║██║     ██╔════╝██╔════╝     
${ESC}[38;2;85;141;219m  ██║  ██║██║   ██║   ██║       █████╗  ██║██║     █████╗  ███████╗     
${ESC}[38;2;102;137;214m  ██║  ██║██║   ██║   ██║       ██╔══╝  ██║██║     ██╔══╝  ╚════██║     
${ESC}[38;2;118;134;209m  ██████╔╝╚██████╔╝   ██║       ██║     ██║███████╗███████╗███████║     
${ESC}[38;2;135;130;204m  ╚═════╝  ╚═════╝    ╚═╝       ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝     

${ESC}[38;2;152;127;198m  ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗ 
${ESC}[38;2;169;123;193m  ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
${ESC}[38;2;185;120;188m  ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
${ESC}[38;2;202;116;183m  ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
${ESC}[38;2;219;113;178m  ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
${ESC}[38;2;236;110;173m  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝   ${ESC}[4;213m${INSTALLER_VERSION}
${ESC}[m
"

#Getting OS
if [ "$(uname)" == 'Darwin' ];then
    OS='Mac'
else
    OS='Linux'
    if type "cmd.exe" > /dev/null 2>&1; then
        OS='Linux_WSL'
    fi
fi

# UI ------------------------------------------
if [ $OS = 'Linux' ];then
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    hackgen_ver="v2.5.1"
    curl -OL https://github.com/yuru7/HackGen/releases/download/${hackgen_ver}/HackGenNerd_${hackgen_ver}.zip
    unzip -o HackGenNerd_${hackgen_ver}.zip
    rm -rf HackGenNerd_${hackgen_ver}.zip
    fc-cache -f -v

    sudo apt install exa

elif [ $OS = 'Mac' ];then

    echo "You need install exa (https://the.exa.website/)"


fi

# Util ----------------------------------------
mkdir -p ~/.util

curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
mv git-completion.bash ~/.util/.
chmod a+x ~/.util/git-completion.bash

curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
mv git-prompt.sh ~/.util/.
chmod a+x ~/.util/git-prompt.sh

[[ ! -e ~/.fzf ]] && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

[[ ! -e ~/.util/enhancd ]] && git clone https://github.com/b4b4r07/enhancd ~/.util/enhancd

if [ $OS = 'Mac' ];then
    [[ ! -e ~/.util/zsh-completions ]] && git clone https://github.com/zsh-users/zsh-completions.git ~/.util/zsh-completions
fi
# copy dotfiles -------------------------------
if [ $OS = 'Mac' ];then
    cp ~/dotfiles/.zshrc ~/.zshrc
else
    cp ~/dotfiles/.bashrc ~/.bashrc
fi

cp ~/dotfiles/.vimrc ~/.vimrc
cp -R ~/dotfiles/.vim ~/.vim
cp ~/dotfiles/.gitconfig ~/.gitconfig

echo Done.
