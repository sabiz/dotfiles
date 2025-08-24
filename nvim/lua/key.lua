vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<ESC>", {silent=true, desc="Exit insert mode"})

vim.keymap.set("n", "<Leader><Right>", ":bnext<CR>", {noremap = true, silent = true, desc="Next buffer"})
vim.keymap.set("n", "<Leader><Left>", ":bprevious<CR>", {noremap = true, silent = true, desc="Previous buffer"})
vim.keymap.set("n", "<Leader><Down>", ":bdelete<CR>", {noremap = true, silent = true, desc="Close buffer"})

local function open_terminal()
  local shell_cmd
  local os_name = vim.loop.os_uname().sysname

  if os_name == "Windows_NT" then
    shell_cmd = "pwsh"
  elseif os_name == "Darwin" then
    shell_cmd = "zsh"
  else
    shell_cmd = "bash"
  end

  local win_height = vim.api.nvim_win_get_height(0)
  local shell_height = math.floor(win_height / 3)

  vim.cmd("botright " .. shell_height .. "split")
  vim.cmd("terminal " .. shell_cmd)

end
vim.keymap.set("n", "<leader>sh", open_terminal, {noremap = true, silent = true, desc="Open terminal"})
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {noremap = true, silent = true, desc="Terminal: Escape to normal mode"})
vim.keymap.set("t", "<C-Left>", [[<C-\><C-n><C-w>h]], {noremap = true, silent = true, desc="Move to left window"})
vim.keymap.set("t", "<C-Down>", [[<C-\><C-n><C-w>j]], {noremap = true, silent = true, desc="Move to lower window"})
vim.keymap.set("t", "<C-Up>", [[<C-\><C-n><C-w>k]], {noremap = true, silent = true, desc="Move to upper window"})
vim.keymap.set("t", "<C-Right>", [[<C-\><C-n><C-w>l]], {noremap = true, silent = true, desc="Move to right window"})

