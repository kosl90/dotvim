#!/bin/bash

function help_info {
    echo "Usage: repo.sh install | update | help"
}

case "$1" in
    "install")
        ln -s ~/.vim/vimrc ~/.vimrc
        chmod +x ./repo.sh
        cd ~/.vim
        git submodule update --init
        ;;
    "update")
        git submodule foreach git pull origin master
        ;;
    "help")
        help_info
        ;;
    "")
        echo "no option is given"
        echo 
        help_info
        ;;
    *)
        echo "Unknown option: '$1'"
        echo
        help_info
        ;;
esac

exit 0
