-- ~/.config/nvim/init.lua
-- Entry point. Order matters: options + keymaps (which sets <leader>) load
-- BEFORE lazy.nvim bootstraps plugins, so plugin keymaps see the right leader.

require("core.options")
require("core.keymaps")
require("core.lazy")
