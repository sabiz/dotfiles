scriptencoding utf-8

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
