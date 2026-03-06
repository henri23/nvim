return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		"RostislavArts/naysayer.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		"zaldih/themery.nvim",
		lazy = false,
		priority = 999,
		keys = {
			{ "<leader>ts", "<cmd>Themery<CR>", desc = "Select theme" },
		},
		config = function()
			require("themery").setup({
				themes = {
					{
						name = "Naysayer",
						colorscheme = "naysayer",
					},
					{
						name = "Handmade Hero",
						colorscheme = "handmade-hero",
					},
					{
						name = "Tokyo Night",
						colorscheme = "tokyonight-night",
						before = [[
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
									hl.Comment = { fg = "#8fbc8f", italic = true }
									hl["@comment"] = { link = "Comment" }
									hl.Visual = { bg = "#2e4a3e" }
									hl.VisualNOS = { bg = "#2e4a3e" }
									hl.CursorLine = { bg = "#1a2f2a" }
									hl.CursorLineNr = { fg = "#a3d9a5", bold = true }
								end,
							})
						]],
					},
				},
				livePreview = true,
				globalBefore = [[
					vim.cmd("hi clear")
					package.loaded["colors.naysayer"] = nil
					package.loaded["colors.handmade-hero"] = nil
				]],
			})
		end,
	},
}
