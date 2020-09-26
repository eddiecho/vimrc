" Plugins
call plug#begin('~/.vim/plugged')

" Plugin Manager - plug.vim
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Reload this file (:source %), then do :PlugInstall

" Filetree
" Menu icons - also download SF mono patched
Plug 'ryanoasis/vim-devicons'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
Plug 'luochen1990/rainbow'

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" C/C++ language semantic highlighting
Plug 'octol/vim-cpp-enhanced-highlight'
" Prettier
Plug 'prettier/vim-prettier', {'do': 'npm install'}
" Coc format on save doesn't respect clang-format????
" This plugin is trash, it runs synchronously, so it locks your editor for
" 10+ seconds on <1000 line file?!?!?!?!?!?!!?!?
" Plug 'rhysd/vim-clang-format', { 'for': ['c', 'cpp'] }
" ClangFormat doesn't use Neovim's async primitives.... vim-clang-format still
" hangs with this?!?!?!?!?
" Plug 'Shougo/vimproc.vim', {'do': 'make'}

" Make the status and tablines better
Plug 'vim-airline/vim-airline'
" Some git stuff, I only want it because it makes airline show the branch name
Plug 'tpope/vim-fugitive'
" Show lines edited since last git commit + stuff
Plug 'airblade/vim-gitgutter'
" Git blame popup
Plug 'rhysd/git-messenger.vim'
" Highlight all occurances of current word
Plug 'RRethy/vim-illuminate'
"Highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" show indentation levels
Plug 'nathanaelkane/vim-indent-guides'

" IDK try it
Plug 'chuling/ci_dark'
" VSCode dark theme for vim
Plug 'tomasiser/vim-code-dark'
" IntelliJ darcula theme for vim
Plug 'doums/darcula'
" Monokai theme
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'crusoexia/vim-monokai'
" Airline themes - I only use minimalist or bubblegum
Plug 'vim-airline/vim-airline-themes'

" Surround
Plug 'tpope/vim-surround'
" Multiple cursors
Plug 'terryma/vim-multiple-cursors'
" Open files with fuzzy match
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Smart increase visual selection
Plug 'terryma/vim-expand-region'
" Better buffer/tab handling
Plug 'qpkorr/vim-bufkill'
" Use <Tab> to scroll through autocompletion lists
Plug 'ervandew/supertab'
" Swap windows
Plug 'wesQ3/vim-windowswap'
" Change Vim's definition of a word to include snake_case and camelCase
Plug 'chaoren/vim-wordmotion'
" Highlight yanked text
Plug 'machakann/vim-highlightedyank'
" Live preview for search and replace
Plug 'markonm/traces.vim'
" HTML, JSX tag completion
Plug 'alvan/vim-closetag'
" Merge conflict highlights
Plug 'rhysd/conflict-marker.vim'
" Better auto pairs?
Plug 'jiangmiao/auto-pairs'
" Show buffer contents
Plug 'junegunn/vim-peekaboo'

call plug#end()

set nocompatible

" Plugin specific setup

" Plugin - CHADTree
nnoremap <leader><space> <cmd>CHADopen<cr>

" Plugin - Multiple cursors
" Use visual mode, then Ctrl+n to create multiple cursors

" Plugin - Surround
" Add with 'ys<selection><surround>'
" Change surroundings with 'cs<firstsurround><newsurround>'
" Delete surroundings with 'ds<delimiter>'

" Plugin - prettier
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 0

" Plugin - CoC
set hidden
" Some completion servers have issues with backup files
set nobackup
set nowritebackup

set cmdheight=2
set shortmess+=c

if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

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
" TODO - just setup format on save for everything
command! -nargs=0 Fmt :call CocAction('format')
" let g:clang_format#detect_style_file = 1
" let g:clang_format#auto_format = 1

" Use `:OrgImport` to organize imports of current buffer
command! -nargs=0 OrgImport :call CocAction('runCommand', 'editor.action.organizeImport')

" Use <shift-space> to trigger completion
inoremap <expr> <S-Space> coc#refresh()

" Add statusline support, checkout :h coc-status
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Plugin - GitGutter
if exists('&signcolumn')
    " set signcolumn=yes
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
" nnoremap <C-p> :FZF<CR>
" fzf file fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or
" unstaged
" else use regular :Files
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"

" Plugin - ExpandRegion
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

" Plugin - AutoPairsGentle
let g:AutoPairsUseInsertedCount = 1

" Plugin - Supertab
let g:SuperTabMappingForward = '<s-tab>'
let g:SuperTabMappingBackward = '<tab>'

" Plugin - WindowSwap
" Use ]ww to swap window placements

" Plugin - Illuminate
let g:Illuminate_delay = 150
let g:Illuminate_highlightUnderCursor = 0
let g:Illuminate_ftblacklist = ['nerdtree']

" Plugin - Vista
"let g:vista_default_executive = 'coc'
"let g:vista#renderer#enable_icon = 1
"
"function! NearestMethodOrFunction() abort
"    return get(b:, 'vista_nearest_method_or_function', '')
"endfunction
"
"set statusline+=%{NearestMethodOrFunction()}
"autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" Plugin - GitMessenger
" <Leader>gm to show the blame
let g:git_messenger_include_diff = 'current'

" Plugin - AutoPairs
let g:AutoPairs = { '(':')', '[':']', '{':'}' }

" End Plugin specific setup

" Map "kj" to esc
imap kj <Esc>

" Line numbers on the left
set number

" 1 tab == 4 space
" TODO - i should change this
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2
autocmd FileType typescriptreact setlocal shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2
autocmd FileType cpp setlocal shiftwidth=2 softtabstop=2
autocmd FileType c setlocal shiftwidth=2 softtabstop=2
autocmd FileType json setlocal shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2

" Auto indent
set ai
set si
set wrap

" show last command entered
set showcmd
set history=500
set encoding=utf-8

syntax enable
let g:airline_theme = 'minimalist'
set termguicolors
colorscheme ci_dark
" let g:sublimemonokai_term_italic = 1

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
set hidden

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
set updatetime=300

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
cnoreabbrev WQ wq
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Wqa wqa
cnoreabbrev WQa wqa
cnoreabbrev Wa wa
cnoreabbrev WA wa
cmap qw wq
cmap qwa wqa
cmap Qw wq
cmap Qwa wqa

" make find next and find prev center the result
nnoremap n nzz
nnoremap N Nzz

set encoding=UTF-8

" save undos
set undodir=~/.vimdid
set undofile

" Clears "last search pattern" by hitting return
nnoremap <CR> :noh<CR><CR>
