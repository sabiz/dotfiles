return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    if vim.fn.executable("tree-sitter") == 1 then
      require("nvim-treesitter").install({ "yaml" })
    end
  end,
}
