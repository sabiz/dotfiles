return {
    {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
      })
      vim.keymap.set("n", "<Leader>f", ":Neotree reveal left<CR>", { desc = "Neo-tree: reveal current file" })
    end,
  }
}
