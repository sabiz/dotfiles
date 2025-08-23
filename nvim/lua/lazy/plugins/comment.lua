return {
    'numToStr/Comment.nvim',
    config = function()
        vim.keymap.set("n", "<Leader>c", "gcc", { remap = true, desc = "Toggle line comment" })
        vim.keymap.set("v", "<Leader>c", "gc",  { remap = true, desc = "Toggle selection comment" })
    end
}
