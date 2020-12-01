" Plugins

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
       \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

" Filetree
" Menu icons - also download SF mono patched
Plug 'ryanoasis/vim-devicons'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
Plug 'luochen1990/rainbow'

" Code completion
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
" Prettier
Plug 'prettier/vim-prettier', {'do': 'npm install', 'for': ['javascript', 'typescript', 'json']}
" Another syntax highlighting thing
Plug 'nvim-treesitter/nvim-treesitter'

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

" Pleasant bluish theme
Plug 'chuling/ci_dark'
" VSCode dark theme for vim
Plug 'tomasiser/vim-code-dark'
" IntelliJ darcula theme for vim
Plug 'doums/darcula'
" Monokai themes, they're ok I guess?
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'crusoexia/vim-monokai'
Plug 'sainnhe/sonokai'
" Airline themes - I only use minimalist or bubblegum
Plug 'vim-airline/vim-airline-themes'

" Surround
Plug 'tpope/vim-surround'
" Multiple cursors
Plug 'mg979/vim-visual-multi'
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
" Plugin - rainbow parens
let g:rainbow_active = 1

" Plugin - CHADTree
nnoremap <leader><space> <cmd>CHADopen<cr>

" Plugin - Multiple cursors
" Use visual mode, then Ctrl+n to create multiple cursors

" Plugin - Surround
" Add with 'ys<selection><surround>'
" Change surroundings with 'cs<firstsurround><newsurround>'
" Delete surroundings with 'ds<delimiter>'

" Plugin - prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 0

" Treesitter syntax highlighting
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    }
}
EOF

" LSP configuration
set hidden
" Some completion servers have issues with backup files
set nobackup
set nowritebackup
set backupcopy=yes

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

" Better completion experience?
" menuone: popup even when there's only one match
" noinsert: do not insert text until a selection is made
" noselect: do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
lua <<EOF

-- lspconfig object
local lspconfig = require'lspconfig'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

require'lspconfig'.tsserver.setup({ on_attach=on_attach })
require'lspconfig'.rust_analyzer.setup({ on_attach=on_attach })
require'lspconfig'.pyls.setup({})

EOF

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Visualize diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = '40'
" don't show diagnostics while in insert mode
let g:diagnostic_insert_delay = 1

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <c-[> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.implementation()<CR>


" try using nvim lsp

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
map <C-K> <Plug>(expand_region_expand)
map <C-J> <Plug>(expand_region_shrink)

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
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
colorscheme sonokai
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
nnoremap H <C-w>h
nnoremap L <C-w>l
nnoremap K <C-w>k
nnoremap J <C-w>j

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
