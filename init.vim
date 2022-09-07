" plugin path
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" ---PLUGINS---
call plug#begin()
    "solidity plugin
    Plug 'tomlion/vim-solidity'
    "Fuzzy searching
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    "colorscheme
    Plug 'morhetz/gruvbox'
    Plug 'arcticicestudio/nord-vim'
    "autocomplete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "Goyo for distraction free prose writing 
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    " auto brackets
    Plug 'jiangmiao/auto-pairs'
    " status bar
    Plug 'vim-airline/vim-airline'
    " Emmet vim
    Plug 'mattn/emmet-vim'
    "GraphQL plugin
    Plug 'jparise/vim-graphql'
    "Copilot
    Plug 'github/copilot.vim'
    "Codi js repl
    Plug 'metakirby5/codi.vim'
    "Ranger
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'
    " vim-elixir
    Plug 'elixir-editors/vim-elixir'
    call plug#end()
let mapleader = ","

"--- PLUGIN SPECIFIC MAPPINGS ---

"Ranger
let g:ranger_map_keys = 0
nnoremap <silent> <Leader>d :Ranger<CR>
"open fuzzy finder
nnoremap <Leader>f :Telescope find_files<CR>
"grep string
nnoremap <Leader>g :Telescope live_grep<CR>
"Toggle goyo
nnoremap <Leader>z :Goyo<CR>
"remove highlighting
nnoremap <Leader>, :noh<CR>

"---LATEX CONFIGURATION---

"nnoremap <Leader>p :silent !cav<CR>
autocmd FileType tex nnoremap <Leader>p :silent !cav<CR>
" set jk to  gj gk for easier text movement when writing prose
autocmd FileType tex nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
autocmd FileType tex nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
autocmd FileType md nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
autocmd FileType md nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
" spell check
autocmd FileType tex set spell spelllang=en_us

"---LIMELIGHT CONFIGURATION---
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_ctermfg = 'gray'

"--- GENERAL CONFIG ---
colorscheme gruvbox
set number
set noswapfile
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set ignorecase
set hlsearch
set incsearch
set textwidth=140
set mouse=a
set relativenumber
set hidden

"--- COC Config ---

" tab completion ala vs-code
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" C-j and C-k menu movement ala spacemacs
inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<C-j>" :
      \ coc#refresh()
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"

"Snippet mapping
nnoremap <Leader>e :CocCommand snippets.editSnippets<CR>
"Restart Coc
nnoremap <silent><Leader>r :CocRestart<CR>
"CocList
nnoremap <Leader>l :CocList<CR>

"jump to definitons cross file
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"Prettier
vmap <C-f>  <Plug>(coc-format-selected)

"Github copilot autocomplete bindings
nmap <silent> <Leader>c :Copilot<CR>

"Open a terminal in a new tab
nmap <silent> <Leader>t :tabnew <bar> :terminal <CR> <bar> i

command Scaffold call ScaffoldStartup()

function ScaffoldStartup()
  terminal
  call feedkeys("iyarn start\<CR>\<C-\>\<C-N>")
  tabnew
  terminal
  call feedkeys("iyarn chain\<CR>\<C-\>\<C-N>")
  tabnew
  terminal
  call feedkeys("iyarn deploy\<CR>\<C-\>\<C-N>")
endfunction
