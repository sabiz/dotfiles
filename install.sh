#!/bin/bash -u

###########################################
###########################################

INSTALLER_VERSION='v0.6.0'
ESC=$(printf '\033')
SCRIPT_PATH=$(dirname $0)/scripts/
HACKGEN_VER="v2.5.3"
TITLE_COLOR_ESCAPE="${ESC}[48;2;52;148;230m${ESC}[38;2;255;255;255m"

export OS=$(${SCRIPT_PATH}get_os.sh)

###########################################

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

# -----------------------------------------------------
echo -e "${TITLE_COLOR_ESCAPE}   Install pre requirements    ${ESC}[m"
# -----------------------------------------------------
if [ $OS = 'Linux' ];then
    sudo apt update
    LINUX_PRE_REQUIREMENTS=(curl unzip)
    for req in "${LINUX_PRE_REQUIREMENTS[@]}";do
        type "$req" > /dev/null 2>&1 || sudo apt install "$req"
        echo "$req"
    done
fi

# -----------------------------------------------------
${SCRIPT_PATH}interactive.sh "${TITLE_COLOR_ESCAPE}   Install Fonts?    ${ESC}[m"
# -----------------------------------------------------
answer=$?
test $answer -eq 0 && ${SCRIPT_PATH}install_font.sh ${HACKGEN_VER}


if [ $OS = 'Linux' ];then

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
