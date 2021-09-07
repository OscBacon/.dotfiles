set nocompatible
filetype off

" set runtime path to include Vundle, initialize
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
Plug 'vim-syntastic/syntastic'
Plug 'jparise/vim-graphql'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
" Plug 'ycm-core/YouCompleteMe'
" Plug 'xavierd/clang_complete'
Plug 'justmao945/vim-clang'
Plug 'sheerun/vim-polyglot'
Plug 'Chiel92/vim-autoformat'
Plug 'psf/black'
"Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'crusoexia/vim-monokai'
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'kaicataldo/material.vim'
" Plug 'fisadev/vim-isort'
Plug 'haya14busa/is.vim'
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/committia.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug '~/.fzf'
Plug 'itchyny/lightline.vim'
Plug 'AndrewRadev/splitjoin.vim' " Join: gJ, split: gS
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern'}
"Plug 'elubow/cql-vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'connorholyday/vim-snazzy'
Plug 'ngemily/vim-vp4'

call plug#end()
filetype plugin indent on

set number
set tabstop=4
set autoindent smartindent
set ruler
set smarttab
set shiftwidth=4
set showmatch
set clipboard+=unnamedplus

set softtabstop=4
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

nnoremap <c-p> :Files<CR>

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

set incsearch

colorscheme onedark

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

" Enable mouse
set mouse=a

set laststatus=2
set noshowmode

set backspace=indent,eol,start

set t_ut=""

set tagstack
set tags=./tags,tags;

hi Normal guibg=NONE ctermbg=NONE
