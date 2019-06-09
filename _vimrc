set nocompatible
filetype off

" set runtime path to include Vundle, initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'jparise/vim-graphql'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'

call vundle#end()
filetype plugin indent on

set number
set tabstop=4
set autoindent
set ruler
set smarttab
set shiftwidth=4
set showmatch
set clipboard=unnamed

au BufNewFile,BufRead *.py
	\ set softtabstop=4 |
	\ set textwidth=79 |
	\ set expandtab

let python_highlight_all=1
syntax on
