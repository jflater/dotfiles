-- plugins/lsp.lua — Mason (installer) + nvim-lspconfig (server wiring).
-- Servers: pyright (Python types/nav), ruff (Python lint/imports), lua_ls,
-- yamlls (snowflake.yml etc.). Plus sqlfluff/stylua as tools.
-- marksman (markdown LSP) removed — crashes with SIGABRT on 0.12 and only useful
-- for wikilink-style note vaults, not standalone markdown files.
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "pyright", "ruff", "lua_ls", "yamlls" },
      automatic_enable = false, -- we enable each server ourselves below (avoids double-attach)
    })
    -- Non-LSP tools (formatter/linter binaries)
    require("mason-tool-installer").setup({
      ensure_installed = { "sqlfluff", "stylua" },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Buffer-local keymaps, attached only when a language server is running
    local on_attach = function(_, bufnr)
      local map = function(keys, fn, desc)
        vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = "LSP: " .. desc })
      end
      map("gd", vim.lsp.buf.definition, "Go to definition")
      map("gr", vim.lsp.buf.references, "References")
      map("K", vim.lsp.buf.hover, "Hover docs")
      map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      map("<leader>ca", vim.lsp.buf.code_action, "Code action")
      map("<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
    end

    -- Apply capabilities + keymaps to every server via the wildcard config
    vim.lsp.config("*", { capabilities = capabilities, on_attach = on_attach })

    -- ruff handles lint + import sorting; let pyright own hover to avoid duplicates
    vim.lsp.config("ruff", {
      on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false
        on_attach(client, bufnr)
      end,
    })

    vim.lsp.config("lua_ls", {
      settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    })

    vim.lsp.enable({ "pyright", "ruff", "lua_ls", "yamlls" })
  end,
}
