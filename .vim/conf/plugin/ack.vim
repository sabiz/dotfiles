if executable('rg')
    let g:ackprg = 'rg --vimgrep --no-heading'
else
    let g:ackprg = 'ag --nogroup --nocolor --column'
endif
nnoremap <Leader>ag :exe("Ack ".expand('<cword>'))<Return>
