-- Custom cheatsheet (no external plugin needed)
return {
  {
    "folke/which-key.nvim", -- Dummy dependency to ensure this loads
    keys = {
      { "<leader>ch", function() require("custom.cheatsheet").toggle() end, desc = "Toggle cheatsheet" },
    },
  },
}
