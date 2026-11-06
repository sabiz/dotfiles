scriptencoding utf-8

let mapleader = "\<Space>"
inoremap jj <Esc>
nnoremap<silent> <Leader><Right> :bnext<CR>
nnoremap<silent> <Leader><Left> :bprev<CR>
nnoremap<silent> <Leader><Down> :bd<CR>
tnoremap<silent> <C-Right> <C-w>:bnext<CR>
tnoremap<silent> <C-Left> <C-w>:bprevious<CR>
command! TShell terminal++hidden
nnoremap <Leader>sh <ESC>:TShell<Return>
nnoremap <Leader>z za

" vim:ft=vim:fdm=marker:fmr={{{,}}}:ts=8:sw=2:sts=2:
