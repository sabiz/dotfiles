return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "neovim/nvim-lspconfig" }
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            sources = cmp.config.sources({
                { name = "buffer" },
                { name = "nvim_lsp" },
                { name = "path" },
                per_filetype = {
                    codecompanion = { "codecompanion" },
                }
            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
        })
    end,
}
