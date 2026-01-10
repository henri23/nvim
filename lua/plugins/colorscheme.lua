return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      on_highlights = function(hl, c)
        -- Darkish green comments
        hl.Comment = { fg = "#6a9955", italic = true }
        hl["@comment"] = { link = "Comment" }
        -- Pink visual selection
        hl.Visual = { bg = "#5d3a5d" }
        hl.VisualNOS = { bg = "#5d3a5d" }
      end,
    })
    vim.cmd([[colorscheme tokyonight-night]])
  end,
}
