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

-- zls is installed outside mason so that its version can follow the Zig toolchain.
vim.lsp.config("zls", {
  settings = {
    zls = {
      -- zls 0.17.0 on Windows keeps build errors for over a minute after they are fixed.
      -- It would also turn this on for any project with a `check` step, so disable it
      -- explicitly and use `:make` (or `:make check` if the project defines it) instead.
      enable_build_on_save = false,
    },
  },
})
vim.lsp.enable("zls")

local function hover()
  vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 30 })
end

local attach_group = vim.api.nvim_create_augroup("my_lsp_attach", { clear = true })
local hold_group = vim.api.nvim_create_augroup("my_lsp_diagnostic_float", { clear = true })
local format_group = vim.api.nvim_create_augroup("my_lsp_format_on_save", { clear = true })

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

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "zls" then
      vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 2000 })
        end,
      })
    end
  end,
})
