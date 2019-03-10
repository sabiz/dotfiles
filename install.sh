#!/bin/bash -eu


#Getting OS
if [ "$(uname)" == 'Darwin' ];then
    OS='Mac'
else
    OS='Linux'
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

# copy dotfiles -------------------------------
if [ $OS = 'Mac' ];then
    cp ~/dotfiles/.bashrc ~/.bash_profile
    echo "source ~/.bash_profile" > ~/.bashrc
else
    cp ~/dotfiles/.bashrc ~/.bashrc
fi

cp ~/dotfiles/.vimrc ~/.vimrc
cp ~/dotfiles/.vim ~/.vim

echo Done.
