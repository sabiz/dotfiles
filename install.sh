#!/bin/bash -u

###########################################
###########################################

INSTALLER_VERSION='v0.8.0'
ESC=$(printf '\033')
SCRIPT_PATH=$(dirname $0)/scripts/
HACKGEN_VER="v2.5.3"
TITLE_COLOR_ESCAPE="${ESC}[48;2;52;148;230m${ESC}[38;2;255;255;255m"
SKIP_AKS=1

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


function installPreRequirements () {
    if [ $1 -ne $SKIP_AKS ];then
        ${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install pre requirements?    ${ESC}[m"
        answer=$?
        if [ $answer -ne 0 ];then
            return 0
        fi
    fi
    if [[ $OS == Linux* ]];then
        sudo apt update
        LINUX_PRE_REQUIREMENTS=(curl unzip git)
        for req in "${LINUX_PRE_REQUIREMENTS[@]}";do
            type "$req" > /dev/null 2>&1 || sudo apt install "$req"
            echo "$req"
        done
    fi
    echo "${TITLE_COLOR_ESCAPE} pre requirements install done. ${ESC}[m"

}

function installFonts () {
    if [ $1 -ne $SKIP_AKS ];then
        ${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install HackGen Fonts?    ${ESC}[m"
        answer=$?
        if [ $answer -ne 0 ];then
            return 0
        fi
    fi
    ${SCRIPT_PATH}install_font.sh ${HACKGEN_VER}
    echo "${TITLE_COLOR_ESCAPE} font install done. ${ESC}[m"
}

function installExa () {
    if [ $1 -ne $SKIP_AKS ];then
        ${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install exa?    ${ESC}[m"
        answer=$?
        if [ $answer -ne 0 ];then
            return 0
        fi
    fi
    if [[ $OS == Linux* ]];then
        sudo apt install exa
    elif [ $OS = 'Mac' ];then
        echo "You need install exa (https://the.exa.website/)"
    fi
    echo "${TITLE_COLOR_ESCAPE} exa install done. ${ESC}[m"
}

function installVim () {
    if [ $1 -ne $SKIP_AKS ];then
        ${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install vim?    ${ESC}[m"
        answer=$?
        if [ $answer -ne 0 ];then
            return 0
        fi
    fi
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
    echo "${TITLE_COLOR_ESCAPE} vim install done. ${ESC}[m"
}

function installUtil () {
    if [ $1 -ne $SKIP_AKS ];then
        ${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install util for bash?    ${ESC}[m"
        answer=$?
        if [ $answer -ne 0 ];then
            return 0
        fi
    fi
    mkdir -p ~/.util

    echo -e "${TITLE_COLOR_ESCAPE} Install git-completion ${ESC}[m"
    curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    mv git-completion.bash ~/.util/.
    chmod a+x ~/.util/git-completion.bash

    echo -e "${TITLE_COLOR_ESCAPE} Install git-prompt ${ESC}[m"
    curl -O https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    mv git-prompt.sh ~/.util/.
    chmod a+x ~/.util/git-prompt.sh

    echo -e "${TITLE_COLOR_ESCAPE} Install Lazygit ${ESC}[m"
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

    if [ $OS = 'Mac' ];then
        echo -e "${TITLE_COLOR_ESCAPE} Install zsh-completions ${ESC}[m"
        [[ ! -e ~/.util/zsh-completions ]] && git clone https://github.com/zsh-users/zsh-completions.git ~/.util/zsh-completions
    fi
    echo "${TITLE_COLOR_ESCAPE} util install done. ${ESC}[m"
}

function installFzf () {
    if [ $1 -ne $SKIP_AKS ];then
        ${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install fzf?    ${ESC}[m"
        answer=$?
        if [ $answer -ne 0 ];then
            return 0
        fi
    fi
    [[ ! -e ~/.fzf ]] && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    echo "${TITLE_COLOR_ESCAPE} fzf install done. ${ESC}[m"
}

function installEnhancd () {
    if [ $1 -ne $SKIP_AKS ];then
        ${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install enhancd?    ${ESC}[m"
        answer=$?
        if [ $answer -ne 0 ];then
            return 0
        fi
    fi
    [[ ! -e ~/.util/enhancd ]] && git clone https://github.com/b4b4r07/enhancd ~/.util/enhancd
    echo "${TITLE_COLOR_ESCAPE} enhancd install done. ${ESC}[m"
}

function installBashrc () {
    if [ $1 -ne $SKIP_AKS ];then
        ${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install bashrc/zshrc?    ${ESC}[m"
        answer=$?
        if [ $answer -ne 0 ];then
            return 0
        fi
    fi
    if [ $OS = 'Mac' ];then
        cp $(dirname $0)/.zshrc ~/.zshrc
    else
        curl -sS https://starship.rs/install.sh | sh
        mkdir -p ~/.config
        cp $(dirname $0)/starship.toml ~/.config/starship.toml
        cp $(dirname $0)/.bashrc ~/.bashrc
    fi
    echo "${TITLE_COLOR_ESCAPE} bashrc/zshrc install done. ${ESC}[m"
}

function installVimrc () {
    if [ $1 -ne $SKIP_AKS ];then
        ${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install vimrc?    ${ESC}[m"
        answer=$?
        if [ $answer -ne 0 ];then
            return 0
        fi
    fi
    cp $(dirname $0)/.vimrc ~/.vimrc
    cp -R $(dirname $0)/.vim ~/.vim
    echo "${TITLE_COLOR_ESCAPE} vimrc install done. ${ESC}[m"
}

function installGitConfig () {
    if [ $1 -ne $SKIP_AKS ];then
        ${SCRIPT_PATH}$INTERACTIVE_SH "${TITLE_COLOR_ESCAPE}   Install gitconfig?    ${ESC}[m"
        answer=$?
        if [ $answer -ne 0 ];then
            return 0
        fi
    fi
    cp $(dirname $0)/.gitconfig ~/.gitconfig
    echo "${TITLE_COLOR_ESCAPE} gitconfig install done. ${ESC}[m"
}

if [ $# -eq 0 ];then
    installPreRequirements 0
    installFonts 0
    installExa 0
    installVim 0
    installUtil 0
    installFzf 0
    installEnhancd 0
    installBashrc 0
    installVimrc 0
    installGitConfig 0
else
    for arg in "$@"; do
        case $arg in
            --pre-requirements)
                installPreRequirements $SKIP_AKS
                ;;
            --fonts)
                installFonts $SKIP_AKS
                ;;
            --exa)
                installExa $SKIP_AKS
                ;;
            --vim)
                installVim $SKIP_AKS
                ;;
            --util)
                installUtil $SKIP_AKS
                ;;
            --fzf)
                installFzf $SKIP_AKS
                ;;
            --enhancd)
                installEnhancd $SKIP_AKS
                ;;
            --bashrc)
                installBashrc $SKIP_AKS
                ;;
            --vimrc)
                installVimrc $SKIP_AKS
                ;;
            --gitconfig)
                installGitConfig $SKIP_AKS
                ;;
            --help)
                echo -e "Usage: $0 [--pre-requirements] [--fonts] [--exa] [--vim] [--util] [--fzf] [--enhancd] [--bashrc] [--vimrc] [--gitconfig]"
                exit 0
                ;;
            *)
                echo "Unknown option: $arg"
                echo -e "Usage: $0 [--pre-requirements] [--fonts] [--exa] [--vim] [--util] [--fzf] [--enhancd] [--bashrc] [--vimrc] [--gitconfig]"
                exit 1
                ;;
        esac
    done
fi
