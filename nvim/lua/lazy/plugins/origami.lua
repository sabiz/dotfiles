return {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {
        autoFold = { enabled = false },
        foldKeymaps = { setup = false },
    },
    config = function(_, opts)
        require("origami").setup(opts)
        vim.keymap.set("n", "<Leader>z", function()
            local lnum = vim.api.nvim_win_get_cursor(0)[1]
            if vim.fn.foldlevel(lnum) == 0 then
                return
            end
            local key = vim.fn.foldclosed(lnum) ~= -1 and "zO" or "zc"
            vim.cmd.normal({ key, bang = true })
        end, { desc = "Toggle fold (recursive open)" })
    end,
}
