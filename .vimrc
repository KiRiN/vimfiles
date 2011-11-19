syntax on
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab

set number
set hlsearch


" neobundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim.git/
  call neobundle#rc(expand('~/.vim/.bundle'))
endif

NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'

filetype plugin on
filetype indent on

