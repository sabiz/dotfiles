local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
       return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        {"nvim-tree/nvim-web-devicons"},
        {"sabiz/skyline-color.nvim"}
    },
    config = function()
        require("lualine").setup({
            options = {
                theme = "catppuccin",
                always_show_tabline = false,
                component_separators = { left = "⎪", right = "⎪" },
                section_separators = { left = "", right = "⁞▐ " },
            },
             sections = {
                 lualine_a = {"mode"},
                 lualine_b = {"branch", "diff", "diagnostics"},
                 lualine_c = {"filename"},
                 lualine_x = {"encoding", "fileformat", "filetype"},
                 lualine_y = {"progress"},
                 lualine_z = {
                     {"location"},
                     {
                         "skyline_color",
                         time_format = "%Y/%m/%d(%a) %H:%M",
                         weekday_style = "ja",
                         fmt=trunc(120,20, 60)
                     }
                 }
             },
        })
    end,
}
