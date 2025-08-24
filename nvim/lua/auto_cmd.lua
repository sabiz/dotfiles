local group = vim.api.nvim_create_augroup("highlightZenkakuSpace", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  group = group,
  callback = function()
    vim.cmd('highlight ZenkakuSpace term=underline ctermbg=Red guibg=Red')
  end,
})
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter" }, {
  group = group,
  callback = function()
    vim.cmd('match ZenkakuSpace /　/')
  end,
})

