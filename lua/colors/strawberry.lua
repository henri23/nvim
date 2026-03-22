-- strawberry.nvim
-- Pinkish accent variant of the Handmade Hero theme.
-- Near-black background, soft pink/rose tones replacing the gold/beige.

local colors = {
	-- Background: same muted near-black
	background  = "#161616",
	float_bg    = "#111111",
	highlight   = "#2a1525",  -- dark plum cursor line
	selection   = "#5c2d4a",
	line_fg     = "#3a3a3a",
	gutter      = "#161616",

	-- Foreground: warm rose-beige for general text
	text        = "#d4a0a0",  -- muted pink-beige
	light_text  = "#e0b0b0",  -- lighter rose for builtins
	white       = "#ffffff",

	-- Comments: plain gray
	comment     = "#7f7f7f",

	-- Keywords: hot pink / rose accent
	keyword     = "#e06080",

	-- Strings/constants: dusty mauve
	string      = "#b07090",
	constant    = "#b07090",
	number      = "#c87898",

	-- Everything else: same rose-beige as text
	variable    = "#d4a0a0",
	function_   = "#d4a0a0",
	type        = "#d4a0a0",
	punctuation = "#d4a0a0",
	macro       = "#e0b0b0",  -- builtins/macros get the lighter rose

	-- Diagnostic/UI accent colors
	error       = "#cc4444",
	warning     = "#c4a000",
	info        = "#87596e",
	hint        = "#87596e",

	-- Cursor: bright pink
	cursor      = "#ff69b4",

	-- Statusline
	lualine_fg  = "#161616",
	lualine_bg  = "#d4a0a0",
}

vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "strawberry"

local set = vim.api.nvim_set_hl

-- Core UI
set(0, "Normal",            { fg = colors.text, bg = colors.background })
set(0, "NormalFloat",       { fg = colors.text, bg = colors.float_bg })
set(0, "FloatBorder",       { fg = colors.line_fg, bg = colors.float_bg })
set(0, "Cursor",            { bg = colors.cursor })
set(0, "Visual",            { bg = colors.selection })
set(0, "VisualNOS",         { bg = colors.selection })
set(0, "LineNr",            { fg = colors.line_fg, bg = colors.background })
set(0, "CursorLineNr",      { fg = colors.text, bg = colors.background, bold = true })
set(0, "CursorLine",        { bg = colors.highlight })
set(0, "ColorColumn",       { bg = "#1e1e1e" })
set(0, "VertSplit",         { fg = colors.line_fg })
set(0, "WinSeparator",      { fg = colors.line_fg })
set(0, "MatchParen",        { bg = colors.selection })
set(0, "SignColumn",        { bg = colors.background })
set(0, "FoldColumn",        { fg = colors.line_fg, bg = colors.background })
set(0, "Folded",            { fg = colors.comment, bg = colors.highlight })
set(0, "NonText",           { fg = colors.line_fg })
set(0, "SpecialKey",        { fg = colors.line_fg })
set(0, "EndOfBuffer",       { fg = colors.background })

-- Search
set(0, "Search",            { fg = colors.background, bg = colors.keyword })
set(0, "IncSearch",         { fg = colors.background, bg = colors.text })
set(0, "CurSearch",         { fg = colors.background, bg = colors.text })

-- Pmenu (completion menu)
set(0, "Pmenu",             { fg = colors.text, bg = colors.float_bg })
set(0, "PmenuSel",          { fg = colors.white, bg = colors.selection })
set(0, "PmenuSbar",         { bg = colors.highlight })
set(0, "PmenuThumb",        { bg = colors.line_fg })

-- Tabline
set(0, "TabLine",           { fg = colors.line_fg, bg = colors.highlight })
set(0, "TabLineSel",        { fg = colors.text, bg = colors.background })
set(0, "TabLineFill",       { bg = colors.float_bg })

-- Title / Messages
set(0, "Title",             { fg = colors.text, bold = true })
set(0, "MsgArea",           { fg = colors.text })
set(0, "MoreMsg",           { fg = colors.comment })
set(0, "Question",          { fg = colors.comment })

-- Syntax: rose-pink tones, minimal coloring
set(0, "Comment",           { fg = colors.comment, italic = true })
set(0, "String",            { fg = colors.string })
set(0, "Number",            { fg = colors.number })
set(0, "Boolean",           { fg = colors.constant })
set(0, "Constant",          { fg = colors.constant })
set(0, "Identifier",        { fg = colors.variable })
set(0, "Function",          { fg = colors.function_ })
set(0, "Statement",         { fg = colors.keyword })
set(0, "Keyword",           { fg = colors.keyword })
set(0, "Operator",          { fg = colors.text })
set(0, "Type",              { fg = colors.type })
set(0, "PreProc",           { fg = colors.macro })
set(0, "Special",           { fg = colors.text })
set(0, "Delimiter",         { fg = colors.punctuation })
set(0, "WarningMsg",        { fg = colors.warning })
set(0, "Error",             { fg = colors.error })
set(0, "ErrorMsg",          { fg = colors.error })
set(0, "Todo",              { fg = colors.keyword, bold = true })

-- Diagnostics
set(0, "DiagnosticError",   { fg = colors.error })
set(0, "DiagnosticWarn",    { fg = colors.warning })
set(0, "DiagnosticInfo",    { fg = colors.info })
set(0, "DiagnosticHint",    { fg = colors.hint })
set(0, "DiagnosticUnderlineError", { sp = colors.error, undercurl = true })
set(0, "DiagnosticUnderlineWarn",  { sp = colors.warning, undercurl = true })
set(0, "DiagnosticUnderlineInfo",  { sp = colors.info, undercurl = true })
set(0, "DiagnosticUnderlineHint",  { sp = colors.hint, undercurl = true })

-- Git signs
set(0, "GitSignsAdd",       { fg = colors.string })
set(0, "GitSignsChange",    { fg = colors.keyword })
set(0, "GitSignsDelete",    { fg = colors.error })

-- Diff
set(0, "DiffAdd",           { bg = "#1a2a1a" })
set(0, "DiffChange",        { bg = "#2a1a2a" })
set(0, "DiffDelete",        { bg = "#2a1a1a" })
set(0, "DiffText",          { bg = "#2a1a25" })

-- Rainbow delimiters
set(0, "rainbowcol1",       { fg = colors.keyword })
set(0, "rainbowcol2",       { fg = colors.comment })
set(0, "rainbowcol3",       { fg = colors.string })
set(0, "rainbowcol4",       { fg = colors.text })
set(0, "rainbowcol5",       { fg = colors.keyword })
set(0, "rainbowcol6",       { fg = colors.comment })

-- Statusline
set(0, "StatusLine",        { fg = colors.lualine_fg, bg = colors.lualine_bg })
set(0, "StatusLineNC",      { fg = colors.line_fg, bg = colors.gutter })

-- Treesitter highlights
set(0, "@comment",          { link = "Comment" })
set(0, "@string",           { link = "String" })
set(0, "@number",           { link = "Number" })
set(0, "@boolean",          { link = "Boolean" })
set(0, "@constant",         { link = "Constant" })
set(0, "@function",         { link = "Function" })
set(0, "@function.builtin", { link = "Function" })
set(0, "@variable",         { link = "Identifier" })
set(0, "@type",             { link = "Type" })
set(0, "@keyword",          { link = "Keyword" })
set(0, "@keyword.function", { link = "Keyword" })
set(0, "@field",            { link = "Identifier" })
set(0, "@property",         { link = "Identifier" })
set(0, "@parameter",        { link = "Identifier" })
set(0, "@operator",         { fg = colors.text })
set(0, "@punctuation",      { fg = colors.punctuation })
set(0, "@punctuation.bracket",    { fg = colors.punctuation })
set(0, "@punctuation.delimiter",  { fg = colors.punctuation })
set(0, "@string.escape",    { fg = colors.keyword })
set(0, "@constructor",      { fg = colors.text })
set(0, "@tag",              { fg = colors.keyword })
set(0, "@tag.attribute",    { fg = colors.text })
set(0, "@tag.delimiter",    { fg = colors.text })

-- Telescope
set(0, "TelescopeNormal",   { fg = colors.text, bg = colors.float_bg })
set(0, "TelescopeBorder",   { fg = colors.line_fg, bg = colors.float_bg })
set(0, "TelescopeSelection", { bg = colors.selection })
set(0, "TelescopeMatching", { fg = colors.keyword, bold = true })

-- Which-key
set(0, "WhichKey",          { fg = colors.keyword })
set(0, "WhichKeyGroup",     { fg = colors.comment })
set(0, "WhichKeyDesc",      { fg = colors.text })
set(0, "WhichKeySeparator", { fg = colors.line_fg })

-- Indent guides
set(0, "IndentBlanklineChar",        { fg = colors.line_fg })
set(0, "IndentBlanklineContextChar", { fg = colors.comment })

return colors
