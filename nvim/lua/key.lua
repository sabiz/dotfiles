vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<ESC>", {silent=true})

local nopts = {noremap = true, silent = true}
vim.keymap.set("n", "<Leader><Right>", ":bnext<CR>", nopts)
-- vim.keymap.set("n", "<Leader><Right>", ":tabnext<CR>", nopts)
vim.keymap.set("n", "<Leader><Left>", ":bprevious<CR>", nopts)
-- vim.keymap.set("n", "<Leader><Left>", ":tabprevious<CR>", nopts)
vim.keymap.set("n", "<Leader><Down>", ":bdelete<CR>", nopts)
-- vim.keymap.set("n", "<Leader><Down>", ":tabclose<CR>", nopts)

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
vim.keymap.set("n", "<leader>sh", open_terminal, nopts)
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], nopts)
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], nopts)
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], nopts)
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], nopts)
