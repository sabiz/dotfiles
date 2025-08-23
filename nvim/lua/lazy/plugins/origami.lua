return {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {},
    config = function()
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
        vim.keymap.set("n", "<Leader>z", function()
            local lnum = vim.api.nvim_win_get_cursor(0)[1]
            local isClosed = vim.fn.foldclosed(lnum) ~= -1
            if isClosed then
                vim.cmd.normal { "zO", bang = true }
            else
                vim.cmd.normal { "zc", bang = true }
            end
        end, { desc = "Toggle fold (recursive open)" })
    end,
}
