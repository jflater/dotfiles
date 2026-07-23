return {
  {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    opts = {
      view = { display_mode = "highlight" },
    },
    keys = {
      { "<leader>ct", "<cmd>CsvViewToggle<cr>", desc = "Toggle CSV table view" },
    },
  },
}
