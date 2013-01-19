#!/bin/bash

function help_info {
    cat <<EOF
Usage: repo.sh init
       repo.sh update [-push]
       repo.sh add url [dirname]
       repo.sh help
EOF
}

case "$1" in
    "init")
        ln -fs $HOME/.vim/vimrc $HOME/.vimrc
        git submodule update --init --recursive
        ;;

    "update")
        git submodule foreach --recursive git pull
        git add .

        if [ "$2" == "-push" ];
        then
            git commit -m 'update plugins'
            git push
        elif [ $2 ];
        then
            echo "Unknown option"
        fi
        ;;

    "add")
        # add from git repository
        # TODO:
        # 1. add from svn repository
        # 2. add from vim.org
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
