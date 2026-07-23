-- core/lazy.lua — bootstrap the lazy.nvim plugin manager, then load every
-- spec file under lua/plugins/ automatically via { import = "plugins" }.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" }, -- every lua/plugins/*.lua is picked up here
  },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true, notify = false }, -- quietly check for updates
  change_detection = { notify = false },
})
