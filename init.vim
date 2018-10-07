" Plugins
call plug#begin('~/.vim/plugged')

" Typescript linter
Plug 'https://github.com/mhartington/nvim-typescript.git'
" Filetree
Plug 'https://github.com/scrooloose/nerdtree.git'
" Surround
Plug 'https://github.com/tpope/vim-surround.git'
" Multiple cursors
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
" Open files with fuzzy match
Plug 'https://github.com/junegunn/fzf.vim.git'

call plug#end()


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


