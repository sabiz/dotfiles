scriptencoding utf-8

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

autocmd BufRead,BufNewFile *.svelte set filetype=svelte

execute('autocmd VimEnter * helptags '.expand(g:vim_home_runtime_path.'/doc'))

" vim:ft=vim:fdm=marker:fmr={{{,}}}:ts=8:sw=2:sts=2:
