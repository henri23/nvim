return {
  -- Trouble (diagnostics)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP definitions (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list (Trouble)" },
    },
    opts = {},
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local todo = require("todo-comments")
      todo.setup()

      vim.keymap.set("n", "]t", function()
        todo.jump_next()
      end, { desc = "Next TODO" })
      vim.keymap.set("n", "[t", function()
        todo.jump_prev()
      end, { desc = "Previous TODO" })
    end,
  },

  -- Spectre (find/replace)
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Spectre",
    keys = {
      { "<leader>fr", function() require("spectre").open() end, desc = "Find and replace (Spectre)" },
    },
  },

  -- Code runner
  {
    "CRAG666/code_runner.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<F5>",
        function()
          -- Use custom envrc runner for C/C++ projects, otherwise use default
          local ft = vim.bo.filetype
          if vim.tbl_contains({ "cpp", "c", "h", "hpp", "cmake" }, ft) then
            require("custom.envrc").run_application()
          else
            vim.cmd("RunCode")
          end
        end,
        desc = "Run code",
      },
    },
    config = function()
      require("code_runner").setup({
        filetype = {
          python = "python3 -u $fileName",
          lua = "lua $fileName",
          dart = "dart $fileName",
          rust = "cd $dir && cargo run",
          go = "cd $dir && go run .",
          javascript = "node $fileName",
          typescript = "npx ts-node $fileName",
        },
        mode = "float",
        focus = true,
        startinsert = true,
        term = {
          position = "bot",
          size = 50,
        },
        float = {
          close_key = "<ESC>",
          border = "rounded",
          height = 0.8,
          width = 0.8,
          x = 0.5,
          y = 0.5,
          border_hl = "FloatBorder",
          float_hl = "Normal",
          blend = 0,
        },
      })
    end,
  },

  -- Visual multi (multiple cursors)
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },

  -- Better escape
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- Terminal (floating)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<F10>", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
      { "<F10>", "<cmd>ToggleTerm direction=float<cr>", mode = "t", desc = "Toggle floating terminal" },
      { "<leader>h", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle horizontal terminal" },
      { "<leader>v", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Toggle vertical terminal" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = nil,
      direction = "float",
      float_opts = {
        border = "curved",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
      },
    },
  },
}
