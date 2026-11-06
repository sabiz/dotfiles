return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  opts = {
    heading = {
      -- default '󰫎 ' can render as 3+ display cells on this environment,
      -- which nvim_buf_set_extmark rejects for sign_text (max 2 cells)
      signs = { "▎" },
    },
    code = {
      -- language icons come from an external icon provider and can't be
      -- swapped per-icon, so disable the sign column rendering for them
      sign = false,
    },
  },
}
