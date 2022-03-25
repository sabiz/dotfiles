nmap <Leader>lf <plug>(lsp-document-format)
nmap <Leader>lh <plug>(lsp-hover)


" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_async_completion = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_document_code_action_signs_enabled = 0
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'allowlist': ['*'],
      \ 'priority': 10,
      \ 'completor': function('asyncomplete#sources#file#completor')
      \ }))

autocmd User lsp_setup ++once call lsp#register_server({
        \ 'name': 'terraform-ls',
        \ 'cmd': {server_info->lsp_settings#get('terraform-ls', 'cmd', [lsp_settings#exec_path('terraform-ls')]+lsp_settings#get('terraform-ls', 'args', ['serve']))},
        \ 'root_uri':{server_info->lsp_settings#get('terraform-ls', 'root_uri', lsp_settings#root_uri('terraform-ls'))},
        \ 'initialization_options': lsp_settings#get('terraform-ls', 'initialization_options', v:null),
        \ 'allowlist': lsp_settings#get('terraform-ls', 'allowlist', ['terraform']),
        \ 'blocklist': lsp_settings#get('terraform-ls', 'blocklist', []),
        \ 'config': lsp_settings#get('terraform-ls', 'config', lsp_settings#server_config('terraform-ls')),
        \ 'workspace_config': lsp_settings#get('terraform-ls', 'workspace_config', {}),
        \ 'semantic_highlight': lsp_settings#get('terraform-ls', 'semantic_highlight', {}),
        \ })

" vim:ft=vim:fdm=marker:fmr={{{,}}}:ts=8:sw=2:sts=2:
