return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "ravitemer/mcphub.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    build = ":TSInstall markdown markdown_inline",
    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "copilot"
                },
                inline = {
                    adapter = "copilot"
                },
                cmd = {
                    adapter = "copilot"
                }
            },
            display = {
                chat = {
                    window = {
                        layout = "horizontal",
                        position = "bottom",
                        height = 0.3,
                    }
                }
            },
            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        make_vars = true,
                        make_slash_commands = true,
                        show_result_in_chat = true
                    }
                }
            }
        })
        vim.keymap.set("n", "<Leader>cc", ":CodeCompanionChat<CR>", { desc = "CodeCompanion Chat" })
        vim.keymap.set("n", "<Leader>ca", ":CodeCompanionActions<CR>", { desc = "CodeCompanion Actions" })
    end,
}
