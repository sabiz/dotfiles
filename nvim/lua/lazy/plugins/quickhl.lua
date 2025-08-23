return {
    "t9md/vim-quickhl",
    config = function()
        vim.keymap.set({ "n", "x" }, "<Leader>m", "<Plug>(quickhl-manual-this)", {
            remap = true,
            desc = "Quickhl: highlight this word",
        })

        vim.keymap.set({ "n", "x" }, "<Space>M", "<Plug>(quickhl-manual-reset)", {
            remap = true,
            desc = "Quickhl: reset manual highlights",
        })
    end,
}
