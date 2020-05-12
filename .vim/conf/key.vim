scriptencoding utf-8

let mapleader = "\<Space>"
inoremap jj <Esc>
nnoremap<silent> <Leader><Right> :bnext<CR>
nnoremap<silent> <Leader><Left> :bprev<CR>
nnoremap<silent> <Leader><Down> :bd<CR>
command! TShell belowright terminal
nnoremap <Leader>sh <ESC>:TShell<Return>

" vim:ft=vim:fdm=marker:fmr={{{,}}}:ts=8:sw=2:sts=2:
