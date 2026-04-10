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
		"ellisonleao/gruvbox.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		priority = 1000,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		priority = 1000,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		"arzg/vim-colors-xcode",
		lazy = true,
		priority = 1000,
	},
	{
		"sainnhe/sonokai",
		lazy = true,
		priority = 1000,
	},
	{
		"navarasu/onedark.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = true,
		priority = 1000,
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		"BoHomola/vsassist.nvim",
		lazy = true,
		priority = 1000,
	},
	{
		"bartekjaszczak/gruv-vsassist.nvim",
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
						name = "Strawberry",
						colorscheme = "strawberry",
					},
					{
						name = "Caelestia (dynamic)",
						colorscheme = "caelestia",
					},
					{
						name = "Xcode Dark",
						colorscheme = "xcodedark",
					},
					{
						name = "Xcode Light",
						colorscheme = "xcodelight",
					},
					{
						name = "Xcode WWDC",
						colorscheme = "xcodewwdc",
					},
					{
						name = "Sonokai",
						colorscheme = "sonokai",
					},
					{
						name = "One Dark",
						colorscheme = "onedark",
						before = [[
							require("onedark").setup({
								style = "dark",
							})
						]],
					},
					{
						name = "Nightfox",
						colorscheme = "nightfox",
					},
					{
						name = "Carbonfox",
						colorscheme = "carbonfox",
					},
					{
						name = "Gruvbox Material",
						colorscheme = "gruvbox-material",
					},
					{
						name = "VS Code Dark",
						colorscheme = "vscode",
						before = [[
							require("vscode").setup({
								style = "dark",
							})
						]],
					},
					{
						name = "Visual Assist",
						colorscheme = "vsassist",
					},
					{
						name = "Gruv Visual Assist",
						colorscheme = "gruv-vsassist",
					},
					{
						name = "Gruvbox Dark",
						colorscheme = "gruvbox",
						before = [[
							require("gruvbox").setup({
								contrast = "hard",
							})
						]],
					},
					{
						name = "Catppuccin Mocha",
						colorscheme = "catppuccin-mocha",
					},
					{
						name = "Rose Pine",
						colorscheme = "rose-pine-main",
					},
					{
						name = "Kanagawa Wave",
						colorscheme = "kanagawa-wave",
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
					package.loaded["colors.strawberry"] = nil
					package.loaded["colors.caelestia"] = nil
				]],
			})
		end,
	},
}
