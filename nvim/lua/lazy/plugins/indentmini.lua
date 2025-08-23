return {
    "nvimdev/indentmini.nvim",
    config = function()
        require("indentmini").setup({
            char = "│",
            only_current = true,
        })
    end,
}
