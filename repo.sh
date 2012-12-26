#!/bin/bash

function help_info {
    echo "Usage: repo.sh init | update | add | help"
}

case "$1" in
    "init")
        ln -s $HOME/.vim/vimrc $HOME/.vimrc
        git submodule update --init --recursive
        ;;

    "update")
        git submodule foreach --recursive git pull
        #git add .
        #git commit -m 'update plugins'
        #git push
        ;;

    "add")
        dirname=$(basename $2)
        dirname=${dirname%%.*}

        if [ $3 ];
        then
            dirname=$3
        fi

        git submodule add $2 bundle/$dirname
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
