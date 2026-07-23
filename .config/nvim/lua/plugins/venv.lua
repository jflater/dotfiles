-- plugins/venv.lua — pick a project's Python virtualenv so pyright/ruff resolve
-- imports correctly.  <leader>vs opens the picker; auto-finds .venv via fd.
-- (Requires Neovim 0.11+, which we now have at 0.12.2.)
return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  ft = "python",
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
  },
  opts = {},
}
