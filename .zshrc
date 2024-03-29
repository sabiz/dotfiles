# .zshrc
# For Mac OS

stty stop undef

# Enviroment----------------------------------------------
export PATH=~/bin:/usr/local/bin:$PATH
export PAGER=less
export EDITOR=vim
export HISTFILESIZE=20000
export HISTSIZE=10000

# Alias--------------------------------------------------
alias ls='exa -Fg'
alias ll='ls -AlFgh'
alias la='ls -CFal'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias sc='screen'
alias ps='ps --sort=start_time'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias less='less -R -N'

# Complete------------------------------------------------
autoload -U compinit
compinit

fpath=(~/.util/zsh-completions/src $fpath)

# Prompt--------------------------------------------------
setopt PROMPT_SUBST
ARROW=$(echo -e "\xEE\x82\xB0")

# ```````````````
#COLOR_SAMPLE
#for i in `seq 0 255`; do echo -n  -e  "\033[38;5;${i}m $i"; done;echo
# ```````````````

source ~/.util/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=false
GIT_PS1_SHOWUPSTREAM=auto

PROMPT=$'%{\e[38;05;12m%}%*%{\e[0m%} - %{\e[38;05;208m%}%n@%m » %~ \$(__git_ps1)\
%{\e[48;05;236;38;05;197m%}\$ %{\e[48;5;12m%}$ARROW %{\e[48;05;236m%}%{\e[38;05;12m%}$ARROW %{\e[0m%}'

# Functions-----------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export ENHANCD_FILTER=fzf
source ~/.util/enhancd/init.sh

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
    *.tar.gz)    tar xvzf $1    ;;
    *.bz2)       bunzip2 $1     ;;
    *.rar)       unrar x $1       ;;
    *.gz)        gunzip $1      ;;
    *.tar)       tar xvf $1     ;;
    *.tbz2)      tar xvjf $1    ;;
    *.tgz)       tar xvzf $1    ;;
    *.zip)       unzip $1       ;;
    *.Z)         uncompress $1  ;;
    *.7z)        7z x $1        ;;
    *)           echo "don't know how to extract '$1'..." ;;
    esac
    else
        echo "'$1' is not a valid file!"
            fi
}

cdAndLs(){
    cd $*&&ls
}

alias cd=cdAndLs

