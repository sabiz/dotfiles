#!/bin/bash -u

###########################################
###########################################

INSTALLER_VERSION='v0.6.0'
ESC=$(printf '\033')
SCRIPT_PATH=$(dirname $0)/scripts/
HACKGEN_VER="v2.5.3"
TITLE_COLOR_ESCAPE="${ESC}[48;2;52;148;230m${ESC}[38;2;255;255;255m"

export OS=$(${SCRIPT_PATH}get_os.sh)

if [[ $OS == Linux* ]];then
    INTERACTIVE_SH="interactive.sh"
else
    # for MacOS zsh
    INTERACTIVE_SH="interactive.zsh"
fi

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
if [[ $OS == Linux* ]];then
    sudo apt update
    LINUX_PRE_REQUIREMENTS=(curl unzip git)
    for req in "${LINUX_PRE_REQUIREMENTS[@]}";do
        type "$req" > /dev/null 2>&1 || sudo apt install "$req"
        echo "$req"
    done
fi

# -----------------------------------------------------
${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install Fonts?    ${ESC}[m"
# -----------------------------------------------------
answer=$?
test $answer -eq 0 && ${SCRIPT_PATH}install_font.sh ${HACKGEN_VER}

# -----------------------------------------------------
${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install exa?    ${ESC}[m"
# -----------------------------------------------------
answer=$?
if [ $answer -eq 0 ];then

    if [[ $OS == Linux* ]];then

        sudo apt install exa

    elif [ $OS = 'Mac' ];then

        echo "You need install exa (https://the.exa.website/)"

    fi

fi

# -----------------------------------------------------
${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install vim from git?    ${ESC}[m"
# -----------------------------------------------------
answer=$?
if [ $answer -eq 0 ];then

    git clone https://github.com/vim/vim.git ~/vim-tmp --depth 1
    trap 'cd -;rm -rf ~/vim-tmp' 2
    if [[ $OS == Linux* ]];then
        sudo apt install gettext libtinfo-dev libacl1-dev libgpm-dev  build-essential
    fi
    cd ~/vim-tmp
    ./configure --enable-fail-if-missing
    make -j5
    sudo make install
    cd -
    rm -rf ~/vim-tmp
fi


# -----------------------------------------------------
${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install util for bash?    ${ESC}[m"
# -----------------------------------------------------
answer=$?
if [ $answer -eq 0 ];then
    mkdir -p ~/.util

    echo -e "${TITLE_COLOR_ESCAPE} Install git-completion ${ESC}[m"
    curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    mv git-completion.bash ~/.util/.
    chmod a+x ~/.util/git-completion.bash

    echo -e "${TITLE_COLOR_ESCAPE} Install git-prompt ${ESC}[m"
    curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    mv git-prompt.sh ~/.util/.
    chmod a+x ~/.util/git-prompt.sh

    if [ $OS = 'Mac' ];then
        echo -e "${TITLE_COLOR_ESCAPE} Install zsh-completions ${ESC}[m"
        [[ ! -e ~/.util/zsh-completions ]] && git clone https://github.com/zsh-users/zsh-completions.git ~/.util/zsh-completions
    fi
fi

# -----------------------------------------------------
${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install fzf?    ${ESC}[m"
# -----------------------------------------------------
answer=$?
if [ $answer -eq 0 ];then

    [[ ! -e ~/.fzf ]] && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

fi

# -----------------------------------------------------
${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install enhancd?    ${ESC}[m"
# -----------------------------------------------------
answer=$?
if [ $answer -eq 0 ];then
    [[ ! -e ~/.util/enhancd ]] && git clone https://github.com/b4b4r07/enhancd ~/.util/enhancd
fi

# -----------------------------------------------------
${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install bashrc/zshrc?    ${ESC}[m"
# -----------------------------------------------------
answer=$?
if [ $answer -eq 0 ];then
    if [ $OS = 'Mac' ];then
        cp $(dirname $0)/.zshrc ~/.zshrc
    else
        cp $(dirname $0)/.bashrc ~/.bashrc
    fi
fi

# -----------------------------------------------------
${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install vimrc?    ${ESC}[m"
# -----------------------------------------------------
answer=$?
if [ $answer -eq 0 ];then
    cp $(dirname $0)/.vimrc ~/.vimrc
    cp -R $(dirname $0)/.vim ~/.vim
fi

# -----------------------------------------------------
${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install gitconfig?    ${ESC}[m"
# -----------------------------------------------------
answer=$?
if [ $answer -eq 0 ];then
    cp $(dirname $0)/.gitconfig ~/.gitconfig
fi

echo Done.
