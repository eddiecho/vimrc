" Plugins
call plug#begin('~/.vim/plugged')

" Plugin Manager - plug.vim
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Reload this file (:source %), then do :PlugInstall 


" Typescript linter
Plug 'https://github.com/mhartington/nvim-typescript.git', {'do': './install.sh'}
Plug 'HerringtonDarkholme/yats.vim'
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
" Code completion
Plug 'valloric/youcompleteme'
" VSCode dark theme for vim
Plug 'tomasiser/vim-code-dark'
" Make the status and tablines better
Plug 'vim-airline/vim-airline'
" Show lines edited since last git commit + stuff
Plug 'airblade/vim-gitgutter'

call plug#end()

" Plugin specific setup

" Plugin - NERDTree 
" Open using Ctrl+m
map <C-m> :NERDTreeToggle<CR>
" <Leader> == \
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

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
" pip install neovim
" Installation guide: https://vimawesome.com/plugin/youcompleteme
" Rust installation guide: https://www.danirod.es/blog/2016/rust-autocompletion-on-
" Make Ctrl+b (IntelliJ default) be the go to hotkey
nnoremap <C-b> :YcmCompleter GoTo<CR>

let g:ycm_register_as_syntastic_checker = 1
let g:Show_diagnostics_ui = 1

" put icons in the gutter
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_open_loclist_on_ycm_diags = 1

let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 0

let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_log_level = 'info'

" GitGutter
if exists('&signcolumn')
    set signcolumn=yes
else
    let g:gitgutter_sign_column_always = 1
endif

" Airline
let g:airline#extensions#tabline#enabled = 1

" End Plugin specific setup

" Map "kj" to esc
imap kj <Esc>  

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

set showcmd     " show last command entered 
set history=500
set encoding=utf-8

syntax enable
let g:airline_theme = 'codedark'
colorscheme codedark

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

" Incremental search
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

" Don't run plugins on files larger than NUM megs
let g:LargeFile = 100

" highlight current line
set cursorline

" folding blocks
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
" space open closes folds
nnoremap <space> za 

" move vertically by visual line, so if a line gets wrapped the 2nd part
" doesn't get skipped
nnoremap j gj
nnoremap k gk

" Split window aliases
" Shift + Left move to left window
nnoremap <S-Left> <C-w>h
nnoremap <S-Right> <C-w>l
nnoremap <S-Up> <C-w>k
nnoremap <S-Down> <C-w>j

" Ctrl + left and right for tab navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-w> :tabclose<CR>

" I typo this all the time
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev Q q
