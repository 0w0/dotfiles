set nocompatible
" Check Vundle is installed or not
filetype plugin on

" Install vim-plug if not installed yet
if empty(glob("~/.vim/autoload/plug.vim"))
    echo "Installing vim-plug.."
    echo ""
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

" Theme/Status bar
Plug 'ikewat/xoria256.vim'
Plug 'itchyny/lightline.vim'
  set laststatus=2
  set noshowmode
  Plug 'maximbaz/lightline-ale'
    let g:lightline = {}
    let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
    let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
    " Somehow it's not working, disable now
    "let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }
" Utils
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } " Fuzzy finder
  let g:Lf_ShortcutF = '<C-P>'
  let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
  map <C-n> :NERDTreeToggle<CR>
  let g:NERDTreeNodeDelimiter = "\u00a0" " Fix ^G
  let NERDTreeShowLineNumbers=1
  let NERDTreeAutoCenter=1
  let NERDTreeShowHidden=1
  let NERDTreeIgnore=['\~$','\.swp']
  let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
  " Open a NERDTree automatically when vim starts up if no files were specified
  " Will print a error..
  "autocmd StdinReadPre * let s:std_in=1
  "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Multiple languages hightlight supports
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-markdown'
Plug 'ekalinin/Dockerfile.vim'
Plug 'pangloss/vim-javascript'
  let g:javascript_plugin_jsdoc = 1
Plug 'reasonml-editor/vim-reason'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntax checker
Plug 'w0rp/ale'
  let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'javascript': ['eslint'],
    \}
  let g:ale_fix_on_save = 1
  " Enable completion where available.
  " This setting must be set before ALE is loaded.
  let g:ale_completion_enabled = 1
call plug#end()

" Basic setting
colorscheme xoria256
syntax on
"set t_Co=256
set signcolumn=yes " Keep signcolumn alway on
highlight clear SignColumn " Make clear cloro on signcolumn
set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
set linespace=15
set nowrap                      " don't wrap lines
" Set default tab behavior
set tabstop=2                   " a tab is four spaces
set softtabstop=2               " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=2                " number of spaces to use for autoindenting
set expandtab                   " expand tabs by default (overloadable per file type later)
set tags=tags
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
set timeout timeoutlen=200 ttimeoutlen=100
set visualbell           " don't beep
set noerrorbells         " don't beep
set autowrite  " Save on buffer switch
set autoread   " Autorefreshing when file changed
set completeopt+=noinsert
" Swap files
set backupdir=~/.vim/backup
set directory=~/.vim/swap

" Key mapping
let mapleader = " "
let g:mapleader = " "
" Fast saves
nmap <leader>w :w!<cr>
" Fast quit
nmap <leader>q :q!<cr>
" Fast page down
nmap <leader>f <C-F><cr>
" Fast page up
nmap <leader>b <C-B><cr>

" Easy escaping to normal model
imap jk <esc><esc>:w<cr>
" Fast add semicolon at end of line
imap <leader>; <esc>A;<cr>

" Auto change directory to match current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Quickly go forward or backward to buffer
nmap <leader>] :bn<cr>
nmap <leader>[ :bp<cr>

" Disable auto comment on next line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
