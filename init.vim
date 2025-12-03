set nocompatible
filetype off

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-scripts/indentpython.vim'
Plug 'jparise/vim-graphql'
Plug 'posva/vim-vue'
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
Plug 'sheerun/vim-polyglot'
Plug 'Chiel92/vim-autoformat' , { 'on': 'Autoformat' }
" Themes
Plug 'crusoexia/vim-monokai'
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'kaicataldo/material.vim'
Plug 'rebelot/kanagawa.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
" Plug 'fisadev/vim-isort'
Plug 'haya14busa/is.vim'
" Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'
" Git conflict markers
Plug 'rhysd/conflict-marker.vim'
Plug 'rhysd/committia.vim'
" Vim
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'scrooloose/nerdcommenter'
Plug '~/.fzf' | Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'AndrewRadev/splitjoin.vim' " Join: gJ, split: gS
"Plug 'elubow/cql-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'josa42/vim-lightline-coc'

" Formatting
Plug 'sbdchd/neoformat'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' }

" Plug 'ngemily/vim-vp4'
Plug 'connorholyday/vim-snazzy'
Plug 'preservim/nerdtree', { 'on' : ['NERDTreeToggle', 'NERDTreeFind', 'NERDTree'] }
" Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vista.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Zen mode
Plug 'junegunn/goyo.vim'

" Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'plasticboy/vim-markdown'

" LSP
Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'

" Kube / Helm
Plug 'towolf/vim-helm'
" Solidity
Plug 'TovarishFin/vim-solidity'
" DAML
Plug 'obsidiansystems/daml.vim'
" MDX 
Plug 'davidmh/mdx.nvim', {'branch': 'main'}
" Go
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'luochen1990/rainbow'
" Icons
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'ryanoasis/vim-devicons'
Plug 'bkad/CamelCaseMotion'
" Indent select
Plug 'michaeljsmith/vim-indent-object'
" Multi cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Dotenv
Plug 'tpope/vim-dotenv'
" DB
Plug 'tpope/vim-dadbod'
" Colors in CSS files
Plug 'ap/vim-css-color'
" Plug 'pmizio/typescript-tools.nvim'
" Firestore
Plug 'delphinus/vim-firestore'
" Markdown preview
Plug '0x00-ketsu/markdown-preview.nvim'
" Window management
" Plug 'nvim-focus/focus.nvim'
" Fancy search and replace
Plug 'nvim-pack/nvim-spectre'
" TODOs
Plug 'folke/todo-comments.nvim'
" Error translation
Plug 'dmmulroy/ts-error-translator.nvim'
" Breadcrumbs
Plug 'Bekaboo/dropbar.nvim'
" UI
Plug 'stevearc/dressing.nvim'
" Color preview
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
"
Plug 'stevearc/aerial.nvim'
" Diff view 
Plug 'sindrets/diffview.nvim'
" Liveshare
Plug 'azratul/live-share.nvim'
Plug 'jbyuki/instant.nvim'
" Copilot
Plug 'github/copilot.vim'
" Extended substitution
Plug 'tpope/vim-abolish'
" AI
Plug 'olimorris/codecompanion.nvim'
" Diff
Plug'nvim-mini/mini.diff'
" Smart incrementing
Plug 'monaqa/dial.nvim'
call plug#end()

filetype plugin indent on

set number
" set relativenumber

set autoindent smartindent
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set backspace=eol,start,indent
set ruler

" let mapleader="\\"
let mapleader=" "

au BufNewFile,BufRead *.js,*.json
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2 |

" Settings for python files
au BufNewFile,BufRead *.py
            \ set tabstop=4 |
            \ set softtabstop=4 |
            \ set shiftwidth=4 |
            \ set textwidth=79 |
            \ set fileformat=unix |

" Settings for haskell files
au BufNewFile,BufRead *.hs
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2 |
            \ set fileformat=unix |

" Settings for elixir files
au BufNewFile,BufRead *.exs
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2 |
            \ set fileformat=unix |

" Setting for verilog files
au BufNewFile,BufRead *.v,*.vs set syntax=verilog

augroup filetype_daml
    au BufNewFile,BufRead *.daml
                \ setlocal tabstop=2 |
                \ setlocal softtabstop=2 |
                \ setlocal shiftwidth=2 

    au Filetype daml setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" Setting for js / jsx files
augroup filetype_jsx
    autocmd!
    autocmd FileType javascript set filetype=javascriptreact
augroup END

autocmd BufWritePre *.ts,*.js,*.yaml,*.tsx :silent Prettier
autocmd BufWritePre *.sol, :silent Neoformat
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END


" Settings for go files
au BufNewFile,BufRead *.go
            \ setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
" autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

au BufNewFile,BufRead *.yaml
            \ set tabstop=2 |
            \ set softtabstop=2 |
            \ set shiftwidth=2 |
            \ set fileformat=unix |

" autocmd FileType go autocmd BufWritePre <buffer> Autoformat

" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"
" Markdown
map <leader>m  :MPToggle<CR>
map <leader>M  :MPRefresh<CR>

" Coc settings
call coc#config('python', {
            \ 'pythonPath': '~/Envs/dev/bin/python'
            \ })

call coc#config('languageserver', {
            \ 'racket': {
            \   'command': 'racket',
            \   'args': [
            \     '--lib',
            \     'racket-langserver'
            \   ],
            \   'filetypes': [
            \     'scheme'
            \   ]
            \ }})

" call coc#config('signature', { 'preferShownAbove': v:false })

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1):
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Fixes autcompletion on multiline
autocmd User visual_multi_mappings  imap <buffer><expr> <CR> coc#pum#visible() ? "\<C-Y>" : "\<Plug>(VM-I-Return)"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" " CoC extensions
let g:coc_global_extensions = [
            \ 'coc-tsserver',
            \ 'coc-clangd',
            \ 'coc-java',
            \ 'coc-elixir',
            \ 'coc-yaml',
            \ 'coc-go',
            \ 'coc-protobuf',
            \ 'coc-clangd',
            \ 'coc-json',
            \ 'coc-sh',
            \ '@nomicfoundation/coc-solidity'
            \ ]

let python_highlight_all=1

set clipboard+=unnamedplus

" Move current line up or down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nnoremap <C-S> :%s/
vnoremap <C-S> :s/

inoremap <A-\> λ
inoremap <A-a> α

set incsearch
set inccommand=split

" Case insensitive search
set ignorecase
" Except if the search contains an uppercase character
set smartcase

" Interface
set noshowmode

" \ 'colorscheme': 'one',
" \ 'colorscheme': 'catppuccin_mocha',
let g:lightline = {
            \ 'colorscheme': 'one',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [  'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], 
            \             [ 'gitbranch','readonly', 'relativepath', 'modified' ] ],
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead'
            \ },
            \ }

" register compoments:
call lightline#coc#register()

set termguicolors
set background=dark
let g:onedark_terminal_italics=1
let g:one_allow_italics = 1
let g:tokyonight_style = "storm"
let g:tokyonight_italic_functions = 1
" colorscheme catppuccin_mocha
" colorscheme molokai
colorscheme kanagawa
hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE
" Display signs in the line numbers columns
set signcolumn=number


" Allow more memory to draw syntax in longer files
set maxmempattern=50000

let g:python3_host_prog = expand('~/Envs/dev/bin/python')

let g:rainbow_active = 1

let g:copilot_filetypes = {
    \ 'dotenv': v:false,
    \ 'yaml': v:false,
    \ 'sh': v:false,
    \ }

" If running ollama-copilot
" let g:copilot_proxy = 'http://localhost:11435'
" let g:copilot_proxy_strict_ssl = v:false

" CoC extensions
let g:coc_global_extensions = ['coc-tsserver']

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :call CocAction('jumpDefinition', 'tabe')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gD <Plug>(coc-declaration)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Fix all issues in document
nmap <leader>qa :CocCommand tsserver.executeAutofix<CR>
nmap <leader>qi :CocCommand editor.action.organizeImport<CR>

nmap <leader>qr :CocCommand document.renameCurrentWord<CR>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Show documentation in preview window
nnoremap <leader>s :call <SID>show_documentation()<CR>

" Search workspace symbols
nnoremap <silent><nowait> <leader>S  :<C-u>CocList -I symbols<cr>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction

" NerdCommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" NerdTree Git Plugin
let g:NERDTreeGitStatusUseNerdFonts = 1
" let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0

for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
    exe 'source' f
endfor

" Settings for WSL
" Open GBrowse links with host browser
let g:netrw_browsex_viewer="cmd.exe /C start"

" Enable copying to win clipboard
" let s:clip = '/c/Windows/System32/clip.exe'
" if executable(s:clip)
"   augroup WSLYank
"     autocmd!
"     autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
"   augroup END
" end

" Enable mouse
set mouse=a

nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>N :NERDTreeFind<cr>
nmap <leader>t :Texplore<cr>
" nmap <leader>S :Sexplore<cr>

set foldmethod=syntax
set foldlevelstart=20

set t_ut=""

set tagstack
set tags=./tags,tags;

function! ToggleLight()
    " if g:colors_name == "onedark"
    "     colorscheme morning
    " else
    "     colorscheme onedark
    "     hi Normal guibg=NONE ctermbg=NONE
    " endif
    " if g:colors_name == "onedark"
    if &background == "dark"
        set background=light
        let g:lightline.colorscheme = 'solarized'
        colorscheme one
    else
        let g:lightline.colorscheme = 'one'
        set background=dark
        colorscheme kanagawa
    endif
    call lightline#init()
    call lightline#colorscheme()
	call lightline#update()
    hi Normal guibg=NONE ctermbg=NONE

endfunction

let s:coc_toggled_outline = 0
function! ToggleOutline()
    if s:coc_toggled_outline == 0
        let s:coc_toggled_outline = 1
        :call CocAction('showOutline')
    else
        let s:coc_toggled_outline = 0
        :call CocAction('hideOutline')
    endif
endfunction

" nmap <F8> :TagbarToggle<CR>
nmap <F8> :Vista!!<CR>
nmap <F9> :call ToggleOutline()<CR>
nnoremap <F12> :call ToggleLight()<CR>
nnoremap <F2> :Goyo<CR>

" Fzf
" nnoremap <silent> <leader>f :Files<CR>
" Open files, ignore .gitignore files
" nnoremap <expr> <leader>f (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached --recurse-submodules')."\<cr>"
" --recurse-submodules not supported with --others
nnoremap <expr> <leader>f (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --recurse-submodules --cached')."\<cr>"
nnoremap <silent> <leader>F :Files<CR>
nnoremap <silent> <leader>b :Buffer<CR>
nnoremap <silent> <leader>l :Lines<CR>
nnoremap <silent> <leader>r :Rg!<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Goyo
let g:goyo_width = 100

function! s:goyo_enter()
    set number
endfunction

function! s:goyo_leave()
    hi Normal guibg=NONE ctermbg=NONE
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:ft = ''
function! NERDCommenter_before()
    if &ft == 'vue'
        let g:ft = 'vue'
        let stack = synstack(line('.'), col('.'))
        if len(stack) > 0
            let syn = synIDattr((stack)[0], 'name')
            if len(syn) > 0
                exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
            endif
        endif
    endif
endfunction
function! NERDCommenter_after()
    if g:ft == 'vue'
        setf vue
        let g:ft = ''
    endif
endfunction

let g:vista_default_executive = 'coc'
let g:vista_sidebar_width = 50

let g:vista_executive_for = {
            \ 'go': 'ctags',
            \ }

" Tagbar
" let g:tagbar_type_typescript = {
"   \ 'ctagstype': 'typescript',
"   \ 'kinds': [
"     \ 'c:classes',
"     \ 'n:modules',
"     \ 'f:functions',
"     \ 'v:variables',
"     \ 'v:varlambdas',
"     \ 'm:members',
"     \ 'i:interfaces',
"     \ 'e:enums',
"   \ ]
" \ }

" Go syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

" function! TwiddleCase(str)
"   if a:str ==# toupper(a:str)
"     let result = tolower(a:str)
"   elseif a:str ==# tolower(a:str)
"     let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
"   else
"     let result = toupper(a:str)
"   endif
"   return result
" endfunction
" vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
vnoremap ~ :s/\(\<\w\+\>\)/\u\1/g<CR>:noh<CR>

" CamelCaseMotion
let g:camelcasemotion_key = ','

syntax on

" Startup command
" NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Explore | endif
if empty(argv())
    NERDTree
endif

" Copilot needs node 20
let g:copilot_node_command = "~/.nvm/versions/node/v22.19.0/bin/node"

" Git
lua << EOF
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    end
}

-- Treesitter
require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = { enable = true },
    indent = { enable = true },
    autotag = { enable = true, enable_close_on_slash = false },
})

require("mdx").setup()
require("ts-error-translator").setup()
-- TODOs
require("todo-comments").setup()
-- Error translation
require("ts-error-translator").setup()
require("dropbar").setup()

require("markdown-preview").setup(
    {
      glow = {
        -- When find executable path of `glow` failed (from PATH), use this value instead
        exec_path = '',
        style = '', -- Path to glamour JSON style file
      },
      -- Markdown preview term
      term = {
        -- reload term when rendered markdown file changed
        reload = {
          enable = true,
          events = {'InsertLeave', 'TextChanged'},
        },
        direction = 'vertical', -- choices: vertical / horizontal
        keys = {
        close = {'q', '<Esc>'},
        refresh = 'r',
        }
      }
    }
)

require("live-share").setup({
    port_internal = 9876, -- The local port to be used for the live share connection
    max_attempts = 20, -- Maximum number of attempts to read the URL from service(serveo.net or localhost.run), every 250 ms
    service_url = "/tmp/service.url", -- Path to the file where the URL from serveo.net will be stored
    service = "nokey@localhost.run", -- Service to use, options are serveo.net or localhost.run
})

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
  filter_kind = {
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
    "Event",
  },
})

require("mini.diff").setup()

require("codecompanion").setup({
  strategies = {
    chat = {
        adapter = "gemini",
    },
    inline = {
        adapter = "gemini",
    }
  },
  gemini = function()
    return require("codecompanion.adapters").extend("gemini", {
      schema = {
        model = {
          default = "gemini-2.5-flash-preview-05-20"
        },
      },
      env = {
        api_key = "GEMINI_API_KEY",
      },
    })
  end,
  --adapters = {
  --  acp = {
  --    gemini_cli = function()
  --      return require("codecompanion.adapters").extend("gemini_cli", {
  --        defaults = {
  --            auth_method = "gemini-api-key",
  --        },
  --        env = {
  --          api_key = "GEMINI_API_KEY",
  --          GEMINI_API_KEY = "GEMINI_API_KEY",
  --        },
  --      })
  --    end,
  --  },
  --},
})

-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- Copilot setup.
-- vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
-- -- Accept the current completion with Ctrl-].
-- vim.keymap.set('i', '<C-]>', 'copilot#Accept("\\<CR>")', {
  -- expr = true,
  -- replace_keycodes = false
-- })
-- Accept the current completion word with Ctrl-\.
vim.keymap.set('i', '<A-.>', '<Plug>(copilot-accept-word)')
-- Accept the current completion line with Ctrl-|.
vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-line)')
-- Request a suggestion with Ctrl-.
-- vim.keymap.set('i', '<C-.>', '<Plug>(copilot-suggest)')

vim.keymap.set({'n', 'v'}, '<leader>c', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>A', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })

-- Dial.nvim setup
local augend = require("dial.augend")
require("dial.config").augends:register_group{
    default = {
        augend.integer.alias.hex,
        augend.date.alias["%d/%m/%Y"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.ja_weekday_full,
        augend.semver.alias.semver,
        augend.constant.alias.bool,
        augend.constant.new{
            elements = {"and", "or"},
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true,  -- "or" is incremented into "and".
        },
        augend.constant.new{
            elements = {"&&", "||"},
            word = false,
            cyclic = true,
        },
    },
}

vim.keymap.set("n", "<C-a>", function()
    require("dial.map").manipulate("increment", "normal")
end)
vim.keymap.set("n", "<C-x>", function()
    require("dial.map").manipulate("decrement", "normal")
end)
vim.keymap.set("n", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gnormal")
end)
vim.keymap.set("n", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gnormal")
end)
vim.keymap.set("x", "<C-a>", function()
    require("dial.map").manipulate("increment", "visual")
end)
vim.keymap.set("x", "<C-x>", function()
    require("dial.map").manipulate("decrement", "visual")
end)
vim.keymap.set("x", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gvisual")
end)
vim.keymap.set("x", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gvisual")
end)

vim.cmd([[cab cc CodeCompanion]])
EOF

" Fuzzy find document symbols
nmap <silent> <leader>ds <cmd>call aerial#fzf()<cr>

" Need to delay because of highlighting setup conflict
function! HighlightConflictMarker() abort
    highlight ConflictMarkerBegin guibg=#2f7366
    highlight ConflictMarkerOurs guibg=#2e5049
    highlight ConflictMarkerTheirs guibg=#344f69
    highlight ConflictMarkerEnd guibg=#2f628e
    highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
endfunction
call timer_start(200, { tid -> execute('call HighlightConflictMarker()') })

au User lsp_setup call lsp#register_server({
    \ 'name': 'damlc',
    \ 'cmd': {server_info->['daml', 'damlc', 'ide', '--RTS', '+RTS', '-M6G', '-N']},
    \ 'whitelist': ['daml'],
    \ })

