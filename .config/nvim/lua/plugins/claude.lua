-- plugins/claude.lua — Claude Code as an IDE-aware pane, in a real tmux split.
-- MCP connection gives Claude your current buffer/selection/diagnostics and
-- lets it show edits as native nvim diffs (:ClaudeCodeDiffAccept/Deny).
-- Falls back to nvim's built-in terminal automatically when not inside tmux
-- (claudecode.nvim does this itself — see get_provider() in its terminal.lua).
return {
  {
    "coder/claudecode.nvim",
    dependencies = { "mr55p-dev/claude-tmux.nvim" },
    cmd = {
      "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSend", "ClaudeCodeAdd",
      "ClaudeCodeTreeAdd", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny",
    },
    keys = {
      { "<leader>ai", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer to Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection to Claude" },
      { "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file to Claude", ft = "neo-tree" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },
    },
    config = function()
      require("claudecode").setup({
        terminal = {
          -- toggle_key left off: smart-splits' <C-h>/<C-l> already crosses into
          -- this pane, and claude-tmux's dynamic bind/unbind of the same key
          -- would otherwise clobber smart-splits' own tmux-side binding.
          provider = require("claude-tmux").setup({
            toggle_key = false,
            split_size = 35,
            split_side = "right",
          }),
        },
      })
    end,
  },
}
