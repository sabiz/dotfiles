# .bashrc

# Source global definitions
[ -f /etc/bashrc ] && source /etc/bashrc

[ -f /etc/bash_completion ] && source /etc/bash_completion

stty stop undef

# Enviroment----------------------------------------------
export PATH=~/bin:$PATH
export PAGER=less
export EDITOR=vim
export HISTFILESIZE=20000
export HISTSIZE=10000
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=01;39;40:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

# Alias--------------------------------------------------
alias ls='exa -F --color=auto'
alias ll='ls -AlFh --show-control-chars --color=auto'
alias la='ls -Fal'
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

source ~/.util/git-completion.bash

# Prompt--------------------------------------------------
ARROW=$(echo -e "\xEE\x82\xB0")

#COLOR_SAMPLE
#for i in `seq 0 255`; do echo -n  -e  "\033[38;5;${i}m $i"; done;echo

source ~/.util/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=false
GIT_PS1_SHOWUPSTREAM=auto

PS1='\
\[\e[38;05;12m\]\t\[\e[0m\] - \[\e[38;05;208m\]\u@\h » \w $(__git_ps1)\n\
\[\e[38;05;197m\]\[\e[40m\]\$ \[\e[48;5;12m\]$ARROW \[\e[40m\]\[\e[38;05;12m\]$ARROW \
\[\e[0m\]'


# Functions-----------------------------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
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

eval "$(starship init bash)"
