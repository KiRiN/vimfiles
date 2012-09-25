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

# check ~/.gvimrc
if [ -e ~/.gvimrc ]; then
    echo ~/.gvimrc already exists
    exit 3
fi

# make symlinks
ln -s $DIR/.vim ~/.vim
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/.gvimrc ~/.gvimrc
echo ~/.vim created successfully
echo ~/.vimrc created successfully
echo ~/.gvimrc created successfully

# git submodule
git submodule init
git submodule update

# others
# make for vimproc
# jshint should be installed for jshint
