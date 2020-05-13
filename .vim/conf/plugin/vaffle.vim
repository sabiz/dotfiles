nmap <Leader>f <ESC>:Vaffle<Return>

let g:vaffle_auto_cd = 1

function! VaffleRenderCustomIcon(item)
    return WebDevIconsGetFileTypeSymbol(a:item.basename, a:item.is_dir)
endfunction

let g:vaffle_render_custom_icon = 'VaffleRenderCustomIcon'

" vim:ft=vim:fdm=marker:fmr={{{,}}}:ts=8:sw=2:sts=2:

