#!/bin/sh

# get directory full path
cd `dirname $0`
DIR=`pwd`

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

# make symlinks
ln -s $DIR/.vim ~/.vim
ln -s $DIR/.vimrc ~/.vimrc
echo ~/.vim created successfully
echo ~/.vimrc created successfully

# git submodule
git submodule init
git submodule update

# make vimproc
echo You should make vimproc for your environment!

