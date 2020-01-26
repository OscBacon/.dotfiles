set nocompatible
filetype off

" set runtime path to include Vundle, initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'jparise/vim-graphql'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'
Plugin 'ervandew/supertab'
Plugin 'kaicataldo/material.vim'
Plugin 'scrooloose/nerdcommenter' 
Plugin 'joshdick/onedark.vim'

call vundle#end()
filetype plugin indent on

set number
set tabstop=2
set autoindent smartindent
set ruler
set smarttab
set shiftwidth=2
set showmatch
set clipboard=unnamedplus

set softtabstop=2
set expandtab

au BufNewFile,BufRead *.py
	\ set softtabstop=4 |
	\ set textwidth=79 |
	\ set expandtab

let python_highlight_all=1
syntax on

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
	exe 'source' f
endfor

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

set incsearch
