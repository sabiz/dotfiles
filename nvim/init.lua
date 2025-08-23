-- Tab ------------------------------------------
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.cindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Search ---------------------------------------
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoindent = true
vim.opt.wrapscan = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Insert ---------------------------------------
vim.opt.backspace = "indent,eol,start"
vim.opt.showmatch = true

-- Buffer ---------------------------------------
vim.opt.formatoptions = vim.opt.formatoptions + "mM"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,cp932"
vim.opt.encoding = "utf-8"
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos"
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.updatetime = 1000
vim.opt.backup = false
vim.opt.undofile = false

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

-- Status ---------------------------------------
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.showmode = false

-- Commandline ----------------------------------
vim.opt.wildmenu = true
vim.opt.cmdheight = 2
vim.opt.showcmd = true
vim.opt.history = 1000
vim.opt.ttyfast = true


-- Mouse ----------------------------------------
vim.opt.mouse = ""
vim.opt.mousefocus = false
vim.opt.mousehide = true

-- Other ----------------------------------------
vim.opt.belloff="all"

require("key")
require("auto_cmd")
require("lazy.main")
require("lsp")
require("neovide")

