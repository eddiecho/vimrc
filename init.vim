" Plugins
call plug#begin('~/.vim/plugged')

" Plugin Manager - plug.vim
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Reload this file (:source %), then do :PlugInstall 


" Typescript linter
Plug 'https://github.com/mhartington/nvim-typescript.git', {'do': './install.sh'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim'
" Filetree
Plug 'https://github.com/scrooloose/nerdtree.git'
" Surround
Plug 'https://github.com/tpope/vim-surround.git'
" Multiple cursors
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
" Open files with fuzzy match
Plug 'https://github.com/junegunn/fzf.vim.git'
" Rust
Plug 'rust-lang/rust.vim'
" Syntastic - syntax highlighting
Plug 'https://github.com/vim-syntastic/syntastic'
" Code completion
Plug 'valloric/youcompleteme'

call plug#end()

" Plugin specific setup

" Plugin - NERDTree 
" Open using Ctrl+n
map <C-m> :NERDTreeToggle<CR>

" Actually close vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Plugin - Multiple cursors
" Use visual mode, then Ctrl+n to create multiple cursors

" Plugin - Surround
" Change surroundings with 'cs<firstsurround><newsurround>'
" Delete surroundings with 'ds<delimiter>'

" Plugin - YouCompleteMe
" There's a lot of config you need to do
" Make sure you have clang, python-dev, python-dev3 packages
" Installation guide: https://vimawesome.com/plugin/youcompleteme

" Plugin - Typescript
let g:deoplete#enable_at_startup = 1

" End Plugin specific setup

" Line numbers on the left
set number

" 1 tab == 4 space
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

" Auto indent
set ai
set si
set wrap

set history=500
set encoding=utf-8

syntax enable
colorscheme monokai

filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" :W sudo saves the file
command W w !sudo tee % > /dev/null

" Auto completion, see :help wildmenu, :help wildmode
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc,*git\*,*/.git/*,*/.DS_Store

" Show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Wrap search results
set incsearch

" Don't redraw while executing macros
set lazyredraw

" For regexes turn magic on
set magic

" Show matching brackets
set showmatch
set mat=2

" No sounds on errors
set noerrorbells
set novisualbell
set tm=500

" Always show the status line
set laststatus=2

" Allow mouse
set mouse=a
