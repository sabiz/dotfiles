let g:lightline = {
\   'colorscheme': 'molokai',
\   'enable': { 'statusline': 1, 'tabline': 0 },
\   'active': {
\       'right': [['SkylineColor'],['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype']]
\   },
\   'component': {
\       'SkylineColor': '%#SkylineColor#%{LightlineSkylineColor()}',
\   }
\}
function! LightlineSkylineColor()
  return winwidth(0) > 70 ? SkylineColor#display() : ''
endfunction
