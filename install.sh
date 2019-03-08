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



# link dotfiles -------------------------------
if [ $OS = 'Mac' ];then
    ln -s ~/dotfiles/.bashrc ~/.bash_profile
    echo "source ~/.bash_profile" > ~/.bashrc
else
    ln -s ~/dotfiles/.bashrc ~/.bashrc
fi
