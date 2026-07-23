-- plugins/editor.lua — small quality-of-life plugins (multiple specs in one file).
return {
  -- Auto-close brackets/quotes
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  -- Comment toggling: gcc (line), gc (visual selection)
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },

  -- Indentation guide lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
}
