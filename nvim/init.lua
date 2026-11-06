-- Tab ------------------------------------------
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Search ---------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Insert ---------------------------------------
vim.opt.showmatch = true

-- Buffer ---------------------------------------
vim.opt.formatoptions = vim.opt.formatoptions + "mM"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,cp932"
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos"
vim.opt.updatetime = 1000

-- View -----------------------------------------
vim.opt.number = true
vim.opt.wrap = false
vim.opt.whichwrap = "b,s,h,l,<,>,[,]"
vim.opt.ambiwidth = "double"
vim.opt.list = true
vim.opt.listchars = "tab:>.,trail:.,eol:$,extends:>,precedes:<,nbsp:%"
vim.opt.title = true
vim.opt.lazyredraw = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Status ---------------------------------------
vim.opt.showmode = false

-- Mouse ----------------------------------------
vim.opt.mouse = ""

require("key")
require("auto_cmd")
require("lazy.main")
require("lsp")
require("neovide")
