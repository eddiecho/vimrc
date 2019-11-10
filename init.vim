" Plugins
call plug#begin('~/.vim/plugged')

" Plugin Manager - plug.vim
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Reload this file (:source %), then do :PlugInstall

" Filetree
Plug 'scrooloose/nerdtree'
" Surround
Plug 'tpope/vim-surround'
" Multiple cursors
Plug 'terryma/vim-multiple-cursors'
" Open files with fuzzy match
Plug 'junegunn/fzf', { 'do': './install --all'}
" VSCode dark theme for vim
Plug 'tomasiser/vim-code-dark'
" Make the status and tablines better
Plug 'vim-airline/vim-airline'
" Show lines edited since last git commit + stuff
Plug 'airblade/vim-gitgutter'
" show indentation levels
Plug 'nathanaelkane/vim-indent-guides'
" Smart increase visual selection
Plug 'terryma/vim-expand-region'
" Show which files have been in changed in nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'
" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Better buffer/tab handling
Plug 'qpkorr/vim-bufkill'
" Menu icons - KEEP THIS LAST - also download the fira code patched font there
Plug 'ryanoasis/vim-devicons'
" Add pairs of parens, etc automatically without feeling awful
Plug 'vim-scripts/auto-pairs-gentle'
" Some git stuff, I only want it because it makes airline show the branch name
Plug 'tpope/vim-fugitive'
" Use <Tab> to scroll through autocompletion lists
Plug 'ervandew/supertab'
" Swap windows
Plug 'wesQ3/vim-windowswap'

call plug#end()

" Plugin specific setup

" Plugin - NERDTree
" Open using Ctrl+m
map <C-m> :NERDTreeToggle<CR>
" <Leader> == \
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" Actually close vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" open on start
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=0
let g:NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = 'v'

" Plugin - Multiple cursors
" Use visual mode, then Ctrl+n to create multiple cursors

" Plugin - Surround
" Add with 'ys<selection><surround>'
" Change surroundings with 'cs<firstsurround><newsurround>'
" Delete surroundings with 'ds<delimiter>'

" Plugin - CoC
set hidden
" Some completion servers have issues with backup files
set nobackup
set nowritebackup

set cmdheight=2
set shortmess+=c

" JSON syntax with comments
autocmd FileType json syntax match Comment +\/\/.\+$+

" GoTo defintions, et al
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use B to show documentation in preview window
nnoremap <silent> B :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:OrgImport` to organize imports of current buffer
command! -nargs=0 OrgImport :call CocAction('runCommand', 'editor.action.organizeImport')

" Add statusline support, checkout :h coc-status
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Plugin - GitGutter
if exists('&signcolumn')
    set signcolumn=yes
else
    let g:gitgutter_sign_column_always = 1
endif
" jump to next hunk = ]c
" jump to prev hunk = [c

" Plugin - Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1

" Plugin - IndentGuides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Plugin - FuzzyFinder
nnoremap <C-p> :FZF<CR>

" Plugin - ExpandRegion
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

" Plugin - AutoPairsGentle
let g:AutoPairsUseInsertedCount = 1

" Plugin - Supertab
let g:SuperTabMappingForward = '<s-tab>'
let g:SuperTabMappingBackward = '<tab>'

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

" show last command entered
set showcmd
set history=500
set encoding=utf-8

syntax enable
let g:airline_theme = 'codedark'
colorscheme codedark

filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Auto completion, see :help wildmenu, :help wildmode
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc,*git\*,*/.git/*,*/.DS_Store

" Show current position
set ruler

" Height of the command bar
set cmdheight=1

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

set splitright
set splitbelow

" folding blocks
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax

" Vim's update delay
set updatetime=100

" move vertically by visual line, so if a line gets wrapped the 2nd part
" doesn't get skipped
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

" Split window aliases
" Shift + Left move to left window
nnoremap <S-Left> <C-w>h
nnoremap <S-Right> <C-w>l
nnoremap <S-Up> <C-w>k
nnoremap <S-Down> <C-w>j

" Ctrl + left and right for tab navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <A-w> :bd<CR>

" Tab for buffer navigation
nnoremap <Tab> :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <S-Tab> :bprevious<CR>:redraw<CR>:ls<CR>
nnoremap <C-w> :BD<CR>

" I typo this all the time
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Wqa wqa
cmap qw wq
cmap qwa wqa
cmap Qw wq
cmap Qwa wqa

" make find next and find prev center the result
nnoremap n nzz
nnoremap N Nzz

set encoding=UTF-8
