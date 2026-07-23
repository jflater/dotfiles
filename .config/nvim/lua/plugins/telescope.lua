-- plugins/telescope.lua — fuzzy finder for files, text (grep), buffers, help.
-- live_grep needs ripgrep (Phase 0); find_files prefers fd but falls back fine.
-- fzf-native is a compiled sorter (needs make+gcc); guarded so a build miss won't break.
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep (needs ripgrep)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",   desc = "Recent files" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({})
    pcall(telescope.load_extension, "fzf") -- ignore if the native build isn't present
  end,
}
