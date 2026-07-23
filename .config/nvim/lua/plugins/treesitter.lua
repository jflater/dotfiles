-- nvim-treesitter removed. Neovim 0.12 has native treesitter built-in but the
-- bundled markdown queries have a 0.12 bug (#set! conceal_lines → nil range() crash).
-- Neovim's regex syntax highlighting handles everything fine without the plugin.
-- Revisit if/when the upstream bug is fixed.
return {}
