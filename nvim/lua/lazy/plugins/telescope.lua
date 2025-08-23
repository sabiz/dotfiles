return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        vim.keymap.set("n", "<Leader>ag", function()
            require("telescope.builtin").grep_string()
        end, { desc = "Telescope grep cursor word" })
    end
}
