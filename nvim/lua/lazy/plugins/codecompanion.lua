return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            interactions = {
                chat = { adapter = "copilot" },
                inline = { adapter = "copilot" },
                cmd = { adapter = "copilot" },
            },
            display = {
                chat = {
                    window = {
                        layout = "horizontal",
                        position = "bottom",
                        height = 0.3,
                    },
                },
            },
        })
        vim.keymap.set("n", "<Leader>ac", ":CodeCompanionChat<CR>", { desc = "CodeCompanion Chat" })
        vim.keymap.set("n", "<Leader>aa", ":CodeCompanionActions<CR>", { desc = "CodeCompanion Actions" })
    end,
}
