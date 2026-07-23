-- plugins/format.lua — conform (format on save) + nvim-lint (diagnostics).
-- Python: ruff (organize imports + format). SQL: sqlfluff (Snowflake dialect via
-- the global ~/.config/sqlfluff config). Lua: stylua.
return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>f", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, desc = "Format buffer" },
    },
    opts = {
      formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
        lua = { "stylua" },
        sql = { "sqlfluff" },
      },
      format_on_save = { timeout_ms = 1500, lsp_format = "fallback" },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = { sql = { "sqlfluff" } }
      -- Dialect comes from the global ~/.config/sqlfluff so we don't override
      -- nvim-lint's parser args (overriding them breaks JSON parsing).
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function() require("lint").try_lint() end,
      })
    end,
  },
}
