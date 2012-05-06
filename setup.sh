#!/bin/sh

DIR=${0%/*}

# check ~/.vim
if [ -e ~/.vim ]; then
    echo ~/.vim already exists
    exit 1
fi

# check ~/.vimrc
if [ -e ~/.vimrc ]; then
    echo ~/.vimrc already exists
    exit 2
fi

# make symlink
ln -s $DIR/.vim ~/.vim
ln -s $DIR/.vimrc ~/.vimrc
echo ~/.vim created successfully
echo ~/.vimrc created successfully
