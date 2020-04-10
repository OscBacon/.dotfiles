filetype off
set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
Plug 'vim-syntastic/syntastic'
Plug 'jparise/vim-graphql'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
"Plug 'ycm-core/YouCompleteMe'
Plug 'sheerun/vim-polyglot'
Plug 'Chiel92/vim-autoformat'
Plug 'psf/black'
"Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'crusoexia/vim-monokai'
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'kaicataldo/material.vim'
Plug 'fisadev/vim-isort'
Plug 'haya14busa/is.vim'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/committia.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug '~/.fzf' | Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
" Nice formatting, use moresymbols branch
Plug 'ehamberg/vim-cute-python', { 'branch': 'moresymbols' }
Plug 'AndrewRadev/splitjoin.vim' " Join: gJ, split: gS
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern'}
"Plug 'elubow/cql-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'connorholyday/vim-snazzy'
call plug#end()

filetype plugin indent on

let g:deoplete#enable_at_startup = 1
set number

set autoindent smartindent
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set backspace=eol,start,indent

" Settings for python files
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set fileformat=unix |

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let python_highlight_all=1
syntax on

set clipboard=unnamedplus

" Move current line up or down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

set incsearch
set inccommand=split

" Interface
set noshowmode

set termguicolors
colorscheme monokai
hi Normal guibg=NONE ctermbg=NONE

let g:python3_host_prog = expand('~/Envs/dev/bin/python')

" NerdCommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
	exe 'source' f
endfor

nnoremap <c-p> :Files<CR>

" Enable copying to win clipboard
let s:clip = '/c/Windows/System32/clip.exe' 
if executable(s:clip)
  augroup WSLYank
    autocmd!
    autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
  augroup END
end

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }
