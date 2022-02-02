#!/bin/zsh -u

echo OK

function draw() {
    echo -n "                                 "
    echo -en "\r"
    if [ $1 -eq 0 ]; then
        echo -n ">"
    else
        echo -n " "
    fi
    echo -n "YES"
    echo -n "   "
    if [ $1 -eq 1 ]; then
        echo -n ">"
    else
        echo -n " "
    fi
    echo -n "NO"
}




echo -e "$1"

CURRENT=0

while true; do

    draw $CURRENT

    read -rsk1 inp
    case "$inp" in
    $'\x1b') # ESC sequence
        read -rsk1 -t 0.1 tmp
        if [[ "$tmp" == "[" ]]; then
            read -rsk1 -t 0.1 tmp
            if [[ "$tmp" == "C" ]] || [[ "$tmp" == "D" ]]; then
                CURRENT=$(($CURRENT ^ 0x1))
            fi
        fi
        ;;
    "y") # Yes
        draw 0
        echo; exit 0
        ;;
    "n") # No
        draw 1
        echo; exit 1
        ;;
    "
") # Enter
        echo
        exit $CURRENT
        ;;
    esac
    read -rsk5 -t 0.1
done
