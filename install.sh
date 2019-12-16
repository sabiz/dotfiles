#!/bin/bash -eu


#Getting OS
if [ "$(uname)" == 'Darwin' ];then
    OS='Mac'
else
    OS='Linux'
fi

# UI ------------------------------------------
if [ $OS = 'Linux' ];then
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    hackgen_ver="v1.4.1"
    curl -OL https://github.com/yuru7/HackGen/releases/download/${hackgen_ver}/HackGen_${hackgen_ver}.zip
    unzip -o HackGen_${hackgen_ver}.zip
    rm -rf HackGen_${hackgen_ver}.zip
    fc-cache -f -v
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
cp ~/dotfiles/.vim ~/.vim

echo Done.
