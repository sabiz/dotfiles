scriptencoding utf-8

let mapleader = "\<Space>"
inoremap jj <Esc>
nnoremap<silent> <Leader><Right> :bnext<CR>
nnoremap<silent> <Leader><Left> :bprev<CR>
nnoremap<silent> <Leader><Down> :bd<CR>
tnoremap<silent> <Leader><Right> <C-w>:bnext<CR>
tnoremap<silent> <Leader><Left> <C-w>:bNext<CR>
command! TShell terminal++hidden
nnoremap <Leader>sh <ESC>:TShell<Return>

" vim:ft=vim:fdm=marker:fmr={{{,}}}:ts=8:sw=2:sts=2:
