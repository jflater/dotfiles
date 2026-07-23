-- plugins/colorscheme.lua — tokyonight (already in your lock file; kept).
-- Alternative to try later: "rebelot/kanagawa.nvim" (what sspaeti uses).
return {
  "folke/tokyonight.nvim",
  lazy = false,    -- a colorscheme should load at startup, not on demand
  priority = 1000, -- ...and before everything else, so nothing flashes unstyled
  config = function()
    require("tokyonight").setup({ style = "night" }) -- night | storm | moon | day
    vim.cmd.colorscheme("tokyonight")
  end,
}
