-- plugins/terminal.lua — toggleterm + Snowflake CLI + Claude pane + :Dev layout.
--   <leader>tt : toggle a horizontal shell at the bottom
--   <leader>ai : toggle the Claude Code pane (vertical, right)
--   <leader>sq : run the CURRENT .sql buffer against lcs_dev
--   :Dev       : open the full layout (tree | file | claude, shell below)
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "Dev" }, -- so `nvim +Dev` can load the plugin at startup
  keys = {
    { "<leader>tt", function() _G.ShellPane() end,  desc = "Toggle terminal" },
    { "<leader>ai", function() _G.ClaudePane() end, desc = "Toggle Claude Code pane" },
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

    -- Singletons: built once, then toggled so the session persists.
    local claude, shell

    _G.ClaudePane = function()
      claude = claude or Terminal:new({
        cmd = "claude",
        direction = "vertical",
        size = math.floor(vim.o.columns * 0.4), -- 40% of screen width
        close_on_exit = false,
        on_open = function() vim.cmd("wincmd L") end, -- far right, full height
      })
      claude:toggle()
    end

    _G.ShellPane = function()
      shell = shell or Terminal:new({
        direction = "horizontal",
        close_on_exit = false,
        on_open = function() vim.cmd("wincmd J") end, -- full-width bottom
      })
      shell:toggle()
    end

    -- :Dev — open all four panes, leave the cursor in the file window.
    vim.api.nvim_create_user_command("Dev", function()
      local main = vim.api.nvim_get_current_win()
      vim.cmd("Neotree show") -- tree on the left
      -- Split each terminal off the FILE window, not off each other.
      vim.api.nvim_set_current_win(main)
      _G.ShellPane() -- horizontal: full-width bottom
      vim.api.nvim_set_current_win(main)
      _G.ClaudePane() -- vertical: right side
      vim.api.nvim_set_current_win(main) -- cursor back in the file
    end, { desc = "Open the dev layout (tree | file | claude, shell below)" })
  end,
}
