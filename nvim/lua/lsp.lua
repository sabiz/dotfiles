vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
    focusable = false,
    max_width = 80,
    max_height = 20,
  },
})

vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local function hover()
  vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 30 })
end

local attach_group = vim.api.nvim_create_augroup("my_lsp_attach", { clear = true })
local hold_group = vim.api.nvim_create_augroup("my_lsp_diagnostic_float", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = attach_group,
  callback = function(args)
    local bufnr = args.buf
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "K", hover, "LSP Hover")
    map("n", "<Leader>lh", hover, "LSP Hover")
    map({ "n", "x" }, "<Leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, "LSP Format")
    map("n", "<Leader>la", vim.lsp.buf.code_action, "LSP Code Action")
    map("n", "<Leader>lr", vim.lsp.buf.rename, "LSP Rename")
    map("n", "<Leader>ld", vim.diagnostic.open_float, "LSP Line Diagnostics")

    vim.api.nvim_clear_autocmds({ group = hold_group, buffer = bufnr })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = hold_group,
      buffer = bufnr,
      callback = function()
        vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
      end,
    })
  end,
})
