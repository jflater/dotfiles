-- plugins/smart-splits.lua — seamless nav/resize across nvim splits AND tmux panes.
-- Must load at startup (not lazy) so tmux's @pane-is-vim check always sees it.
return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  opts = {},
  keys = {
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, mode = { "n", "t" }, desc = "Window left" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, mode = { "n", "t" }, desc = "Window down" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, mode = { "n", "t" }, desc = "Window up" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, mode = { "n", "t" }, desc = "Window right" },
    { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize left" },
    { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize down" },
    { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize up" },
    { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize right" },
  },
}
