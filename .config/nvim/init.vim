set exrc
set guicursor=
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set nowrap
set showmatch
set ignorecase
set ttyfast
set spell
set encoding=utf8

filetype plugin indent on
syntax on

let mapleader = " "
inoremap jh <Esc>
inoremap jk <Esc>
inoremap kl <Esc>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>

nnoremap <leader>  :let @/=''<CR>:noh<CR>|       " clear search
nnoremap <leader>b :ls<CR>:buffer<space>|        " show/select buffer
nnoremap <leader>d :w !diff % -<CR>|             " show diff
nnoremap <silent> <leader>i gg=G``<CR>|          " fix indentation
nnoremap <leader>l :set list! list?<CR>|         " toggle list (special chars)
nnoremap <leader>n :set invnumber number?<CR>|   " toggle line numbers
nnoremap <leader>p :!python3 % " run file in python<CR>|
nnoremap <leader>r :retab<CR>|                   " convert tabs to spaces
nnoremap <silent> <leader>t :%s/\s\+$//e<CR>|    " trim whitespace
nnoremap <leader>w :set wrap! wrap?<CR>|         " toggle wrapping
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map j gj
map k gk
map $ g$
map 0 g0

nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

nnoremap <leader>y "+y
xnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

call plug#begin('~/.vim/plugged')
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'sharkdp/fd'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'BurntSushi/ripgrep'

Plug 'gruvbox-community/gruvbox'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'lilydjwg/colorizer'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim'
Plug 'mbbill/undotree'
call plug#end()

colo gruvbox
highlight Normal guibg=none

" Autocmds
autocmd BufWritePost *.tex silent! !pdflatex <afile>
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
