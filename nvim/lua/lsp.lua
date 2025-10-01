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

do
  local orig = vim.lsp.handlers["textDocument/hover"]
  vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    config = config or {}
    config.border = config.border or "rounded"
    config.focusable = config.focusable or false
    config.max_width = config.max_width or 80
    config.max_height = config.max_height or 30
    local bufnr, winid = orig(err, result, ctx, config)
    if winid and vim.api.nvim_win_is_valid(winid) then
      pcall(vim.api.nvim_set_option_value, "wrap", true,      { win = winid })
      pcall(vim.api.nvim_set_option_value, "linebreak", true, { win = winid })
      pcall(vim.api.nvim_set_option_value, "number", false,   { win = winid })
      pcall(vim.api.nvim_set_option_value, "relativenumber", false, { win = winid })
    end
    return bufnr, winid
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf

    vim.keymap.set("n", "<Leader>lh", function()
      vim.lsp.buf.hover()
    end, { buffer = bufnr, desc = "LSP Hover" })
    vim.keymap.set({ "n", "v" }, "<Leader>lf", function()
      vim.lsp.buf.format({
        async = true,
      })
    end, { buffer = bufnr, desc = "LSP Format" })
    vim.keymap.set("n", "<Leader>la", function()
      vim.lsp.buf.code_action()
    end, { buffer = bufnr, desc = "LSP Code Action" })
    vim.keymap.set("n", "<Leader>lr", function()
      vim.lsp.buf.rename()
    end, { buffer = bufnr, desc = "LSP Rename" })
    vim.keymap.set("n", "<Leader>ld", function()
      vim.diagnostic.open_float()
    end, { buffer = bufnr, desc = "LSP Line Diagnostics" })

    local last_pos -- {line, col}
    local last_float_win

    local function close_float()
      if last_float_win and vim.api.nvim_win_is_valid(last_float_win) then
        pcall(vim.api.nvim_win_close, last_float_win, true)
      end
      last_float_win = nil
    end

    local function open_diagnostic_float()
      local mode = vim.api.nvim_get_mode().mode
      if not mode:match("^[nvV%s]") then
        return
      end

      local pos = vim.api.nvim_win_get_cursor(0)
      if last_pos and last_pos[1] == pos[1] and last_pos[2] == pos[2] then
        return
      end
      last_pos = { pos[1], pos[2] }

      local line = pos[1] - 1
      local diags = vim.diagnostic.get(bufnr, { lnum = line })
      if not diags or #diags == 0 then
        close_float()
        return
      end

      close_float()
      last_float_win = vim.diagnostic.open_float(bufnr, {
        focus = false,
        scope = "cursor",
        border = "rounded",
        source = "if_many",
        max_width = 80,
        max_height = 20,
        severity_sort = true,
      })

      if last_float_win and vim.api.nvim_win_is_valid(last_float_win) then
        pcall(vim.api.nvim_set_option_value, "wrap", true,      { win = last_float_win })
        pcall(vim.api.nvim_set_option_value, "linebreak", true, { win = last_float_win })
        pcall(vim.api.nvim_set_option_value, "number", false,   { win = last_float_win })
        pcall(vim.api.nvim_set_option_value, "relativenumber", false, { win = last_float_win })
      end
    end

    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        vim.schedule(open_diagnostic_float)
      end,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      callback = function()
        close_float()
      end,
    })

    vim.api.nvim_create_autocmd({ "BufHidden", "BufLeave" }, {
      buffer = bufnr,
      callback = close_float,
    })
  end,
})
