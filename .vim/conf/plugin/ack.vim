if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
else
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif
nnoremap <Leader>ag :exe("Ack ".expand('<cword>'))<Return>

" vim:ft=vim:fdm=marker:fmr={{{,}}}:ts=8:sw=2:sts=2:
