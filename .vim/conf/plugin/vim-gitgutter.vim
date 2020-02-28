nmap <Leader>g] <Plug>(GitGutterNextHunk)
nmap <Leader>g[ <Plug>(GitGutterPrevHunk)
nmap <Leader>gp <Plug>(GitGutterPreviewHunk)
autocmd vimenter * GitGutterLineHighlightsToggle
let g:gitgutter_max_signs = 10000
let g:gitgutter_preview_win_floating = 1
