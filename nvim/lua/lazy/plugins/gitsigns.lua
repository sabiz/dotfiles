return {
  "lewis6991/gitsigns.nvim",
  lazy=false,
  config = function()
    require("gitsigns").setup({
        on_attach = function(bufnr)
            vim.keymap.set("n", "<Leader>g]", ":Gitsigns nav_hunk next<CR>", {buffer=bufnr, desc="Next Hunk"})
            vim.keymap.set("n", "<Leader>g[", ":Gitsigns nav_hunk prev<CR>", {buffer=bufnr, desc="Prev Hunk"})
            vim.keymap.set("n", "<Leader>gp", ":Gitsigns preview_hunk<CR>", {buffer=bufnr, desc="Preview Hunk"})
        end
    })
  end
}
