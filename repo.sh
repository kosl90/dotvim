#!/bin/bash

function help_info {
    echo "Usage: repo.sh install | update | help"
}

case "$1" in
    "init")
        if [ -d bundle && -s bunlde ];
        then
            ln -s ~/.vim/vimrc ~/.vimrc
            chmod +x ./repo.sh
            cd ~/.vim
            git submodule update --init
        else
            echo "Initialization had been done"
        fi
        ;;

    "update")
        git submodule foreach git pull origin master
        ;;

    "install")
        dirname=$(basename $2)
        dirname=${dirname%%.*}

        if [ $3 ];
        then
            dirname=$3
        fi

        git submodule add $2 bundle/$dirname
        ;;

    "add_sub")
        git submodule add bundle/$2
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
