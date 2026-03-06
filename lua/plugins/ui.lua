return {
  -- Lualine (statusline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Alpha (Doom Emacs-style dashboard)
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Doom Emacs logo (official ASCII art)
      dashboard.section.header.val = {
        [[=================     ===============     ===============   ========  ========]],
        [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
        [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
        [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
        [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
        [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
        [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
        [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
        [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
        [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
        [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
        [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
        [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
        [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
        [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
        [[||.=='    _-'                                                     `' |  /==.||]],
        [[=='    _-'                        N E O V I M                         \/   `==]],
        [[\   _-'                                                                `-_   /]],
        [[ `''                                                                      ``' ]],
      }

      -- Buttons with icons
      dashboard.section.buttons.val = {
        dashboard.button("SPC f f", "󰈞  Find File", ":Telescope find_files<CR>"),
        dashboard.button("SPC f w", "󰊄  Find Word", ":Telescope live_grep<CR>"),
        dashboard.button("SPC f o", "󰷊  Recent Files", ":Telescope oldfiles<CR>"),
        dashboard.button("SPC e e", "󰙅  File Explorer", ":NvimTreeToggle<CR>"),
        dashboard.button("SPC l g", "󰊢  Git", ":LazyGit<CR>"),
        dashboard.button("SPC c h", "󰋖  Cheatsheet", ":lua require('custom.cheatsheet').toggle()<CR>"),
        dashboard.button("e", "󰎔  New File", ":ene <BAR> startinsert<CR>"),
        dashboard.button("c", "󰒓  Config", ":e $MYVIMRC<CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "󰩈  Quit", ":qa<CR>"),
      }

      -- Footer
      dashboard.section.footer.val = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
      end

      -- Centering
      dashboard.section.header.opts.hl = "DoomHeader"
      dashboard.section.header.opts.position = "center"
      dashboard.section.buttons.opts.hl = "DoomButton"
      dashboard.section.footer.opts.hl = "DoomFooter"

      -- Dynamic vertical centering
      local function get_padding()
        local header_lines = 19
        local button_lines = 10
        local footer_lines = 1
        local total_content = header_lines + button_lines + footer_lines + 4
        local win_height = vim.fn.winheight(0)
        return math.max(0, math.floor((win_height - total_content) / 2))
      end

      -- Layout
      dashboard.config.layout = {
        { type = "padding", val = get_padding },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      dashboard.config.opts.noautocmd = true
      alpha.setup(dashboard.config)

      -- Doom color scheme
      vim.api.nvim_set_hl(0, "DoomHeader", { fg = "#51afef", bold = true })
      vim.api.nvim_set_hl(0, "DoomButton", { fg = "#bbc2cf" })
      vim.api.nvim_set_hl(0, "DoomFooter", { fg = "#5B6268", italic = true })
    end,
  },

  -- Noice (UI improvements)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      routes = {
        {
          filter = { event = "notify", find = "No information available" },
          opts = { skip = true },
        },
      },
      presets = {
        lsp_doc_border = true,
      },
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
    },
  },

  -- Notify
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require("notify")
    end,
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader>c", group = "Code/Cheatsheet" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Hunk" },
        { "<leader>o", group = "Opencode" },
        { "<leader>w", group = "Workspace" },
        { "<leader>t", group = "Theme" },
        { "<leader>x", group = "Trouble" },
      })
    end,
  },

  -- Indent blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { char = "│", show_start = false, show_end = false },
    },
  },

  -- Web devicons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}
