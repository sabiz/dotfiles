scriptencoding utf-8
"""""""""""""""""""""""""""""""""""""
" Common Config
"""""""""""""""""""""""""""""""""""""
set ignorecase
set smartcase
set tabstop=4
set expandtab
set autoindent
set backspace=indent,eol,start
set wrapscan
set showmatch
set wildmenu
set formatoptions+=mM
set number
set ruler
set nowrap
set laststatus=2
set cmdheight=2
set showcmd
set title
set fileencoding=utf-8
set fileencodings=utf-8,cp932
set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos
set hidden
set autoread
set history=1000
set updatetime=1000
set nobackup
set incsearch
set hlsearch
set ambiwidth=double
set cindent
set shiftwidth=4
set smarttab
set softtabstop=4
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set list
set listchars=tab:>.,trail:.,eol:$,extends:>,precedes:<,nbsp:%
set noundofile
set cmdheight=2
set noshowmode
set lazyredraw
set ttyfast
set mouse-=a
if has('gui_running')
    set mouse=a
    set columns=200
    set lines=50
endif
set nomousefocus
set mousehide
set belloff=all
filetype on
filetype plugin on
filetype indent on

let g:vim_home_runtime_path=expand('~/.vim')
if has('win32')
    let g:vim_home_runtime_path=expand('~/vimfiles')
endif

let g:vim_home_runtime_conf_path = g:vim_home_runtime_path.'/conf'


"""""""""""""""""""""""""""""""""""""
" Key Binds
"""""""""""""""""""""""""""""""""""""
execute('source '.g:vim_home_runtime_conf_path.'/key.vim')

"""""""""""""""""""""""""""""""""""""
" Auto Command
"""""""""""""""""""""""""""""""""""""
execute('source '.g:vim_home_runtime_conf_path.'/auto_cmd.vim')

"""""""""""""""""""""""""""""""""""""
" Plugin Config
"""""""""""""""""""""""""""""""""""""
execute('source'.g:vim_home_runtime_conf_path.'/plugins.vim')

