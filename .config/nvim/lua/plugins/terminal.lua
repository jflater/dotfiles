-- plugins/terminal.lua — toggleterm: quick scratch shell + Snowflake CLI runner.
-- The persistent shell pane and the Claude pane now live in tmux (see
-- ~/.tmux.conf's `prefix + D` and plugins/claude.lua) instead of nested here.
--   <leader>tt : toggle a quick scratch shell at the bottom (doesn't touch tmux)
--   <leader>sq : run the CURRENT .sql buffer against lcs_dev
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = "ToggleTerm",
  keys = {
    { "<leader>tt", function() _G.ShellPane() end, desc = "Toggle terminal" },
    {
      "<leader>sq",
      function()
        local file = vim.fn.expand("%:p")
        if not file:match("%.sql$") then
          vim.notify("Current buffer is not a .sql file", vim.log.levels.WARN)
          return
        end
        local cmd = string.format("snow sql -f '%s' --connection lcs_dev", file)
        require("toggleterm.terminal").Terminal
          :new({ cmd = cmd, direction = "horizontal", close_on_exit = false })
          :toggle()
      end,
      desc = "Snow: run current SQL file (lcs_dev)",
    },
  },
  opts = {
    size = 15,
    direction = "horizontal",
    start_in_insert = true,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    local Terminal = require("toggleterm.terminal").Terminal

    -- Singleton: built once, then toggled so the session persists.
    local shell

    _G.ShellPane = function()
      shell = shell or Terminal:new({
        direction = "horizontal",
        size = function() return math.floor(vim.o.lines * 0.25) end,
        close_on_exit = false,
        on_open = function() vim.cmd("wincmd J") end, -- full-width bottom
      })
      shell:toggle()
    end
  end,
}
