-- core/options.lua — editor behavior (the vim.opt settings)
local opt = vim.opt

-- Line numbers (absolute on current line, relative elsewhere — fast motions)
opt.number = true
opt.relativenumber = true

-- Indentation: 4 spaces, no tabs (matches the Python / SQL you write)
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search: case-insensitive unless you type a capital
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- UI
opt.termguicolors = true -- 24-bit color (tokyonight needs this)
opt.signcolumn = "yes" -- always show gutter (git/diagnostics) — prevents text jump
opt.cursorline = true
opt.scrolloff = 8 -- keep 8 lines of context around the cursor
opt.wrap = false
opt.colorcolumn = "100" -- subtle guide at column 100

-- Files / persistent undo
opt.undofile = true -- undo survives closing the file
opt.swapfile = false
opt.backup = false

-- Splits open where you expect
opt.splitright = true
opt.splitbelow = true

-- Responsiveness
opt.mouse = "a"
opt.updatetime = 250 -- quicker diagnostics + CursorHold
opt.timeoutlen = 400 -- how long which-key waits before popping up

-- System clipboard. NOTE (WSL): if yanking to the Windows clipboard doesn't
-- work, install win32yank.exe and put it on PATH — nvim auto-detects it.
opt.clipboard = "unnamedplus"

-- Markdown: soft-wrap at word boundaries
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})
