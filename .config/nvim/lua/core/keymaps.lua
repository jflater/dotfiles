-- core/keymaps.lua — base keymaps.
-- Leader is set FIRST, before any plugin loads, so every plugin keymap agrees on it.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Save / quit
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<cr>",  { desc = "Quit window" })

-- Clear search highlight with Esc
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Window nav (normal + terminal mode) and cross-boundary tmux nav/resize
-- now live in plugins/smart-splits.lua — that plugin has to own <C-h/j/k/l>
-- so tmux's @pane-is-vim detection works.

-- Resize splits with Ctrl + arrows
map("n", "<C-Up>",    "<cmd>resize +2<cr>",          { desc = "Taller" })
map("n", "<C-Down>",  "<cmd>resize -2<cr>",          { desc = "Shorter" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>", { desc = "Narrower" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Wider" })

-- Move selected lines up/down (visual mode)
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Keep the cursor centered when half-paging and jumping search results
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Diagnostics jump (active once LSP is configured). Float/list keymaps live in lsp.lua.
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
