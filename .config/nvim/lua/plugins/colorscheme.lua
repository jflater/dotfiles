-- plugins/colorscheme.lua — tokyonight (already in your lock file; kept).
-- Alternative to try later: "rebelot/kanagawa.nvim" (what sspaeti uses).
return {
  "folke/tokyonight.nvim",
  lazy = false,    -- a colorscheme should load at startup, not on demand
  priority = 1000, -- ...and before everything else, so nothing flashes unstyled
  config = function()
    require("tokyonight").setup({
      style = "night", -- night | storm | moon | day
      on_highlights = function(hl, c)
        -- Default WinSeparator/NormalNC are both nearly the same color as
        -- the background — makes split boundaries (e.g. neo-tree | code)
        -- hard to see. Brighten the border, dim inactive windows slightly.
        hl.WinSeparator = { fg = c.blue, bold = true }
        hl.NormalNC = { bg = c.bg_dark }
      end,
    })
    vim.cmd.colorscheme("tokyonight")
  end,
}
