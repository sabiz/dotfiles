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
inoremap <c-f> <right>
inoremap <c-b> <left>
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
"""""""""""""""""""""""""""""""""""""
" Key Binds
"""""""""""""""""""""""""""""""""""""
inoremap <c-f> <right>
inoremap <c-b> <left>
let mapleader = "\<Space>"
nnoremap <Leader>l <ESC><C-w>>
nnoremap <Leader>h <ESC><C-w><
inoremap jj <Esc>
nnoremap<silent> <Leader><Right> :bnext<CR>
nnoremap<silent> <Leader><Left> :bprev<CR>
nnoremap<silent> <Leader><Down> :bd<CR>
tnoremap<silent> <Leader><Right> <C-w>:bnext<CR>
tnoremap<silent> <Leader><Left> <C-w>:bNext<CR>
command! TShell terminal++hidden
nnoremap <Leader>sh <ESC>:TShell<Return>

"""""""""""""""""""""""""""""""""""""
" Auto Command
"""""""""""""""""""""""""""""""""""""
augroup highlightZenkakuSpace
    autocmd!
    autocmd VimEnter,ColorScheme * highlight ZenkakuSpace term=underline ctermbg=Red guibg=Red
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
augroup END
augroup molokaiTablineScheme
  autocmd!
  autocmd ColorScheme * highlight TabLineSel term=NONE cterm=NONE ctermfg=233 ctermbg=161 gui=NONE guifg=#232526 guibg=#F92672
  autocmd ColorScheme * highlight TabLine term=NONE cterm=NONE ctermfg=161 ctermbg=233 gui=NONE guifg=#f92672 guibg=#232526
augroup END

"""""""""""""""""""""""""""""""""""""
" Plugin Config
"""""""""""""""""""""""""""""""""""""
" Plugin install --------------------------
if has('win32')
    let PLUGIN_PATH = expand('~/vimfiles/pack/plugin/start/')
else
    let PLUGIN_PATH = expand('~/.vim/pack/plugin/start/')
endif
if !isdirectory(PLUGIN_PATH)
    call mkdir(PLUGIN_PATH, 'p')
endif
let PLUGIN_LIST = {
    \'ack.vim' : 'https://github.com/mileszs/ack.vim.git',
    \'async.vim' : 'https://github.com/prabirshrestha/async.vim.git',
    \'asyncomplete-file.vim' : 'https://github.com/prabirshrestha/asyncomplete-file.vim',
    \'asyncomplete-lsp.vim' : 'https://github.com/prabirshrestha/asyncomplete-lsp.vim.git',
    \'asyncomplete.vim' : 'https://github.com/prabirshrestha/asyncomplete.vim.git',
    \'editorconfig-vim' : 'https://github.com/editorconfig/editorconfig-vim.git',
    \'lightline.vim' : 'https://github.com/itchyny/lightline.vim.git',
    \'molokai' : 'https://github.com/tomasr/molokai.git',
    \'rainbow_csv' : 'https://github.com/mechatroner/rainbow_csv.git',
    \'skyline-color.vim' : 'https://github.com/sabiz/skyline-color.vim.git',
    \'tagbar' : 'https://github.com/majutsushi/tagbar',
    \'tcomment_vim' : 'https://github.com/tomtom/tcomment_vim.git',
    \'vaffle.vim' : 'https://github.com/cocopon/vaffle.vim.git',
    \'vim-autoclose' : 'https://github.com/Townk/vim-autoclose.git',
    \'vim-buftabline' : 'https://github.com/ap/vim-buftabline.git',
    \'vim-cheatsheet' : 'https://github.com/reireias/vim-cheatsheet.git',
    \'vim-gitgutter' : 'https://github.com/airblade/vim-gitgutter.git',
    \'vim-indent-guides' : 'https://github.com/sabiz/vim-indent-guides.git',
    \'vim-lsp' : 'https://github.com/prabirshrestha/vim-lsp.git',
    \'vim-quickhl' : 'https://github.com/t9md/vim-quickhl.git',
    \'vim-auto-cursorline' : 'https://github.com/delphinus/vim-auto-cursorline'
    \}

if executable('git')
    let pluginNames = keys(PLUGIN_LIST)
    " Remove unused plugins
    let dirList = split(expand(PLUGIN_PATH . '*'), '\n')
    for d in dirList
        if match(pluginNames, fnamemodify(d, ':t')) == -1
            call delete(expand(d), 'rf')
            echo 'Delete ' . fnamemodify(d, ':t')
        endif
    endfor

    for i in pluginNames
        let clonePath = PLUGIN_PATH . i
        if isdirectory(clonePath)
            continue
        endif
        call system('git ' . 'clone ' . PLUGIN_LIST[i] . ' ' . clonePath)
        if v:shell_error == 0
            echo i . ' OK'
        else
            echo i . ' Error...'
        endif
    endfor
else
    echo 'Cannot find [git]...'
endif
autocmd vimenter * helptags ALL

" TComment --------------------------
vmap <Leader>c gcc
nmap <Leader>c gcc

" Vaffle ----------------------------
nmap <Leader>f <ESC>:Vaffle<Return>
let g:vaffle_auto_cd = 1

" GitGutter -------------------------
nmap <Leader>g] <Plug>(GitGutterNextHunk)
nmap <Leader>g[ <Plug>(GitGutterPrevHunk)
nmap <Leader>gp <Plug>(GitGutterPreviewHunk)
autocmd vimenter * GitGutterLineHighlightsToggle
let g:gitgutter_max_signs = 10000
let g:gitgutter_preview_win_floating = 1

" quickhl ---------------------------
nmap <Leader>m <Plug>(quickhl-manual-this)
xmap <Leader>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

" Ack -------------------------------
let g:ackprg = 'ag --nogroup --nocolor --column'
nnoremap <Leader>ag :exe("Ack ".expand('<cword>'))<Return>

" indent guides ---------------------
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

" molokai ---------------------------
set t_ut=
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
syntax on
set cursorline
set t_Co=256

" SkylineColor ----------------------
let g:SkylineColor_TimeFormat = '%Y/%m/%d(%a) %H:%M'

" lightline -------------------------
let g:lightline = {
\   'colorscheme': 'molokai',
\   'enable': { 'statusline': 1, 'tabline': 0 },
\   'active': {
\       'right': [['SkylineColor'],['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype']]
\   },
\   'component': {
\       'SkylineColor': '%#SkylineColor#%{LightlineSkylineColor()}',
\   }
\}
function! LightlineSkylineColor()
  return winwidth(0) > 70 ? SkylineColor#display() : ''
endfunction

" tagbar ----------------------------
nmap<silent> <Leader>o :TagbarToggle<CR>

" asyncomplete ----------------------
let g:asyncomplete_auto_popup = 1

" vim-cheatsheet ----------------------
let g:cheatsheet#cheat_file = '~/.vim/doc/cheat_sheet.md'

" vim-lsp ---------------------------
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_async_completion = 1
let g:lsp_diagnostics_float_cursor = 1
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
if executable('sourcekit-lsp')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
        \ 'whitelist': ['sh'],
        \ })
endif
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })
endif
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

