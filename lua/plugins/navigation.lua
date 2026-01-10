return {
  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      local map = vim.keymap.set

      map("n", "<leader>m", mark.add_file, { desc = "Harpoon add file" })
      map("n", "<leader>ml", ui.toggle_quick_menu, { desc = "Harpoon toggle menu" })
      map("n", "<leader>hm", ":Telescope harpoon marks<CR>", { desc = "Harpoon marks (Telescope)" })

      -- Jump to harpoon files by number (1-9, 0 for 10th)
      for i = 1, 9 do
        map("n", "<leader>" .. i, function()
          ui.nav_file(i)
        end, { desc = "Harpoon jump to file " .. i })
      end
      map("n", "<leader>0", function()
        ui.nav_file(10)
      end, { desc = "Harpoon jump to file 10" })
    end,
  },

  -- Tmux navigator
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right" },
    },
  },

  -- Maximizer
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<cr>", desc = "Maximize split" },
    },
  },
}
