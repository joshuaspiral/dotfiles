set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.
set autoread                                     " reload on external file changes
set encoding=utf8                                " enable utf8 support set hidden                                       " hide buffers, don't close set mouse=a                                      " enable mouse support
set wildmenu wildmode=longest:full,full        
set termguicolors 

set listchars=eol:¶,trail:•,tab:▸\               " whitespace characters
set scrolloff=999                                " center cursor position vertically
set showbreak=¬\                                 " Wrapping character
set showmatch                                    " show matching brackets
set lazyredraw                                   " enable lazyredraw

let mapleader=','                                " leader key

inoremap jh <Esc>
nnoremap <leader>, :let @/=''<CR>:noh<CR>|       " clear search
noremap <leader># :g/\v^(#\|$)/d_<CR>|          " delete commented/blank lines
nnoremap <leader>b :ls<CR>:buffer<space>|        " show/select buffer
nnoremap <leader>d :w !diff % -<CR>|             " show diff
nnoremap <silent> <leader>i gg=G``<CR>|          " fix indentation
nnoremap <leader>l :set list! list?<CR>|         " toggle list (special chars)
nnoremap <leader>n :set invnumber number?<CR>|   " toggle line numbers
nnoremap <leader>p :!python3 % " run file in python<CR>|
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
nnoremap <leader>r :retab<CR>|                   " convert tabs to spaces
nnoremap <leader>s :source $MYVIMRC<CR>|         " reload .vimrc
nnoremap <silent> <leader>t :%s/\s\+$//e<CR>|    " trim whitespace
nnoremap <leader>w :set wrap! wrap?<CR>|         " toggle wrapping
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map j gj
map k gk

call plug#begin('~/.vim/plugged')
Plug 'rebelot/kanagawa.nvim'
Plug 'morhetz/gruvbox'

Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lilydjwg/colorizer'
Plug 'jiangmiao/auto-pairs'
call plug#end()

colo kanagawa
syntax enable
set splitright 
set splitbelow

autocmd BufWritePost *.tex silent! !pdflatex <afile>
