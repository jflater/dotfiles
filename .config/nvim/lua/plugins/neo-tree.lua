-- plugins/neo-tree.lua — file explorer sidebar.  <leader>e toggles it.
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree", -- so `:Dev` / other commands can load neo-tree on demand
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer (neo-tree)" },
  },
  opts = {
    filesystem = {
      follow_current_file = { enabled = true }, -- highlight the file you're editing
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,            -- auto-refresh on external changes
    },
    window = { width = 32 },
  },
}
