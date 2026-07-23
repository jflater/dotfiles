-- plugins/lualine.lua — statusline: git branch, diagnostics, filetype, position.
-- Icons come from nvim-web-devicons (needs the Nerd Font from Phase 0 to look right).
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "tokyonight",
      globalstatus = true,           -- one statusline across all splits
      section_separators = "",
      component_separators = "",
    },
  },
}
