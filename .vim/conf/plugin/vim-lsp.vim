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
" vim:ft=vim:fdm=marker:fmr={{{,}}}:ts=8:sw=2:sts=2:
