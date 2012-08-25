#!/bin/sh

# check ~/.vim
if [ -e ~/.vim ]; then
    echo rm ~/.vim
    rm ~/.vim
fi

# check ~/.vimrc
if [ -e ~/.vimrc ]; then
    echo rm ~/.vimrc
    rm ~/.vimrc
fi

# check ~/.gvimrc
if [ -e ~/.gvimrc ]; then
    echo rm ~/.gvimrc
    rm ~/.gvimrc
fi

