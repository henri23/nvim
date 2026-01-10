return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- New nvim-treesitter (main branch) only handles parser installation
    -- Highlighting is handled by Neovim 0.11+ core via vim.treesitter.start()
    -- Parsers need to be installed manually via :TSInstall <language>
  end,
}
