" plugin path
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" ---PLUGINS---
call plug#begin()
    "solidity plugin
    Plug 'tomlion/vim-solidity'
    "Nice file explorer
    Plug 'preservim/nerdtree'
    "Fuzzy searching
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    "colorscheme
    Plug 'morhetz/gruvbox'
    "autocomplete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "Goyo for distraction free writing 
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    "Formatter
    Plug 'sbdchd/neoformat'
call plug#end()
let mapleader=","

"--- PLUGIN SPECIFIC MAPPINGS ---

"open tree
nnoremap <Leader>t :NERDTreeToggle<CR>
"open fuzzy finder
nnoremap <Leader>f :Telescope find_files<CR>
"grep string
nnoremap <Leader>g :Telescope grep_string<CR>
"Toggle goyo
nnoremap <Leader>z :Goyo 85%x85%<CR>
"remove highlighting
nnoremap <Leader>, :noh<CR>

"---LATEX CONFIGURATION---

"nnoremap <Leader>p :silent !cav<CR>
autocmd FileType tex nnoremap <Leader>p :silent !cav<CR>
" set jk to  gj gk for easier text movement when writing prose
autocmd FileType tex nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
autocmd FileType tex nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
" spell check
autocmd FileType tex set spell spelllang=en_us

"---LIMELIGHT CONFIGURATION---
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight! 
let g:limelight_conceal_ctermfg = 'gray'

"--- GENERAL CONFIG ---
colorscheme gruvbox
set noswapfile
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set ignorecase
set hlsearch
set incsearch
"COC Config
if exists('*complete_info')
  inoremap <silent><expr> <cr> complete_info(['selected'])['selected'] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
