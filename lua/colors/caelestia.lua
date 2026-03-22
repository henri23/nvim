-- caelestia.nvim
-- Dynamic colorscheme that reads from caelestia's generated palette.
-- Minimal highlighting style (like handmade-hero), beige text preserved,
-- only accent colors (keywords, strings, cursor, surfaces) follow the wallpaper.

local M = {}

local scheme_path = vim.fn.expand("~/.local/state/caelestia/scheme.json")

local function hex(color)
	if not color then return nil end
	if color:sub(1, 1) == "#" then return color end
	return "#" .. color
end

local function read_scheme()
	local f = io.open(scheme_path, "r")
	if not f then return nil end
	local raw = f:read("*a")
	f:close()
	local ok, data = pcall(vim.json.decode, raw)
	if not ok or not data or not data.colours then return nil end
	return data.colours
end

-- Handmade-hero fallback colors for when caelestia is unavailable
local fallback = {
	background  = "#161616",
	float_bg    = "#111111",
	highlight   = "#191970",
	selection   = "#264f78",
	line_fg     = "#3a3a3a",
	gutter      = "#161616",
	text        = "#cdaa7d",
	light_text  = "#dab98f",
	white       = "#ffffff",
	comment     = "#7f7f7f",
	keyword     = "#cd950c",
	string      = "#6b8e23",
	constant    = "#6b8e23",
	number      = "#6b8e23",
	variable    = "#cdaa7d",
	function_   = "#cdaa7d",
	type        = "#cdaa7d",
	punctuation = "#cdaa7d",
	macro       = "#dab98f",
	error       = "#cc4444",
	warning     = "#c4a000",
	info        = "#5f8787",
	hint        = "#5f8787",
	cursor      = "#40ff40",
	lualine_fg  = "#161616",
	lualine_bg  = "#cdaa7d",
}

local function build_colors(c)
	if not c then return fallback end

	return {
		background  = hex(c.base) or fallback.background,
		float_bg    = hex(c.mantle) or fallback.float_bg,
		highlight   = hex(c.surface0) or fallback.highlight,
		selection   = hex(c.surface2) or fallback.selection,
		line_fg     = hex(c.overlay0) or fallback.line_fg,
		gutter      = hex(c.base) or fallback.gutter,

		-- Text: keep the beige, untouched
		text        = "#cdaa7d",
		light_text  = "#dab98f",
		white       = "#ffffff",

		-- Comments: caelestia's warm gray (like casey's gray50)
		comment     = hex(c.subtext0) or fallback.comment,

		-- Keywords: muted dark primary (like casey's DarkGoldenrod3)
		keyword     = hex(c.primaryPaletteKeyColor) or fallback.keyword,

		-- Strings/constants: muted dark tertiary (like casey's OliveDrab)
		string      = hex(c.tertiaryPaletteKeyColor) or fallback.string,
		constant    = hex(c.tertiaryPaletteKeyColor) or fallback.constant,
		number      = hex(c.tertiaryPaletteKeyColor) or fallback.number,

		-- Everything else: same beige as text
		variable    = "#cdaa7d",
		function_   = "#cdaa7d",
		type        = "#cdaa7d",
		punctuation = "#cdaa7d",
		macro       = "#dab98f",

		-- Diagnostics (muted)
		error       = hex(c.error) or fallback.error,
		warning     = hex(c.secondaryPaletteKeyColor) or fallback.warning,
		info        = hex(c.outline) or fallback.info,
		hint        = hex(c.outline) or fallback.hint,

		-- Cursor: muted primary
		cursor      = hex(c.primaryPaletteKeyColor) or fallback.cursor,

		-- Statusline
		lualine_fg  = hex(c.base) or fallback.lualine_fg,
		lualine_bg  = "#cdaa7d",
	}
end

local function apply(c)
	local colors = build_colors(c)

	vim.cmd("highlight clear")
	vim.o.background = "dark"
	vim.g.colors_name = "caelestia"

	local set = vim.api.nvim_set_hl

	-- Core UI
	set(0, "Normal",            { fg = colors.text, bg = colors.background })
	set(0, "NormalFloat",       { fg = colors.text, bg = colors.float_bg })
	set(0, "FloatBorder",       { fg = colors.line_fg, bg = colors.float_bg })
	set(0, "Cursor",            { bg = colors.cursor })
	set(0, "Visual",            { bg = colors.selection })
	set(0, "VisualNOS",         { bg = colors.selection })
	set(0, "LineNr",            { fg = colors.line_fg, bg = colors.background })
	set(0, "CursorLineNr",     { fg = colors.text, bg = colors.background, bold = true })
	set(0, "CursorLine",       { bg = colors.highlight })
	set(0, "ColorColumn",      { bg = colors.highlight })
	set(0, "VertSplit",         { fg = colors.line_fg })
	set(0, "WinSeparator",     { fg = colors.line_fg })
	set(0, "MatchParen",       { bg = colors.selection })
	set(0, "SignColumn",       { bg = colors.background })
	set(0, "FoldColumn",       { fg = colors.line_fg, bg = colors.background })
	set(0, "Folded",           { fg = colors.comment, bg = colors.highlight })
	set(0, "NonText",          { fg = colors.line_fg })
	set(0, "SpecialKey",       { fg = colors.line_fg })
	set(0, "EndOfBuffer",      { fg = colors.background })

	-- Search
	set(0, "Search",           { fg = colors.background, bg = colors.keyword })
	set(0, "IncSearch",        { fg = colors.background, bg = colors.text })
	set(0, "CurSearch",        { fg = colors.background, bg = colors.text })

	-- Pmenu
	set(0, "Pmenu",            { fg = colors.text, bg = colors.float_bg })
	set(0, "PmenuSel",         { fg = colors.white, bg = colors.selection })
	set(0, "PmenuSbar",        { bg = colors.highlight })
	set(0, "PmenuThumb",       { bg = colors.line_fg })

	-- Tabline
	set(0, "TabLine",          { fg = colors.line_fg, bg = colors.highlight })
	set(0, "TabLineSel",       { fg = colors.text, bg = colors.background })
	set(0, "TabLineFill",      { bg = colors.float_bg })

	-- Title / Messages
	set(0, "Title",            { fg = colors.text, bold = true })
	set(0, "MsgArea",          { fg = colors.text })
	set(0, "MoreMsg",          { fg = colors.comment })
	set(0, "Question",         { fg = colors.comment })

	-- Syntax: beige for almost everything, minimal coloring
	set(0, "Comment",          { fg = colors.comment, italic = true })
	set(0, "String",           { fg = colors.string })
	set(0, "Number",           { fg = colors.number })
	set(0, "Boolean",          { fg = colors.constant })
	set(0, "Constant",         { fg = colors.constant })
	set(0, "Identifier",       { fg = colors.variable })
	set(0, "Function",         { fg = colors.function_ })
	set(0, "Statement",        { fg = colors.keyword })
	set(0, "Keyword",          { fg = colors.keyword })
	set(0, "Operator",         { fg = colors.text })
	set(0, "Type",             { fg = colors.type })
	set(0, "PreProc",          { fg = colors.macro })
	set(0, "Special",          { fg = colors.text })
	set(0, "Delimiter",        { fg = colors.punctuation })
	set(0, "WarningMsg",       { fg = colors.warning })
	set(0, "Error",            { fg = colors.error })
	set(0, "ErrorMsg",         { fg = colors.error })
	set(0, "Todo",             { fg = colors.keyword, bold = true })

	-- Diagnostics
	set(0, "DiagnosticError",  { fg = colors.error })
	set(0, "DiagnosticWarn",   { fg = colors.warning })
	set(0, "DiagnosticInfo",   { fg = colors.info })
	set(0, "DiagnosticHint",   { fg = colors.hint })
	set(0, "DiagnosticUnderlineError", { sp = colors.error, undercurl = true })
	set(0, "DiagnosticUnderlineWarn",  { sp = colors.warning, undercurl = true })
	set(0, "DiagnosticUnderlineInfo",  { sp = colors.info, undercurl = true })
	set(0, "DiagnosticUnderlineHint",  { sp = colors.hint, undercurl = true })

	-- Git signs
	set(0, "GitSignsAdd",     { fg = colors.string })
	set(0, "GitSignsChange",  { fg = colors.keyword })
	set(0, "GitSignsDelete",  { fg = colors.error })

	-- Diff
	set(0, "DiffAdd",         { bg = colors.highlight })
	set(0, "DiffChange",      { bg = colors.highlight })
	set(0, "DiffDelete",      { bg = colors.selection })
	set(0, "DiffText",        { bg = colors.selection })

	-- Rainbow delimiters
	set(0, "rainbowcol1",     { fg = colors.keyword })
	set(0, "rainbowcol2",     { fg = colors.comment })
	set(0, "rainbowcol3",     { fg = colors.string })
	set(0, "rainbowcol4",     { fg = colors.text })
	set(0, "rainbowcol5",     { fg = colors.keyword })
	set(0, "rainbowcol6",     { fg = colors.comment })

	-- Statusline
	set(0, "StatusLine",      { fg = colors.lualine_fg, bg = colors.lualine_bg })
	set(0, "StatusLineNC",    { fg = colors.line_fg, bg = colors.gutter })

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
	set(0, "@punctuation.bracket",   { fg = colors.punctuation })
	set(0, "@punctuation.delimiter", { fg = colors.punctuation })
	set(0, "@string.escape",   { fg = colors.keyword })
	set(0, "@constructor",     { fg = colors.text })
	set(0, "@tag",             { fg = colors.keyword })
	set(0, "@tag.attribute",   { fg = colors.text })
	set(0, "@tag.delimiter",   { fg = colors.text })

	-- Telescope
	set(0, "TelescopeNormal",    { fg = colors.text, bg = colors.float_bg })
	set(0, "TelescopeBorder",    { fg = colors.line_fg, bg = colors.float_bg })
	set(0, "TelescopeSelection", { bg = colors.selection })
	set(0, "TelescopeMatching",  { fg = colors.keyword, bold = true })

	-- Which-key
	set(0, "WhichKey",          { fg = colors.keyword })
	set(0, "WhichKeyGroup",     { fg = colors.comment })
	set(0, "WhichKeyDesc",      { fg = colors.text })
	set(0, "WhichKeySeparator", { fg = colors.line_fg })

	-- Indent guides
	set(0, "IndentBlanklineChar",        { fg = colors.line_fg })
	set(0, "IndentBlanklineContextChar", { fg = colors.comment })
end

-- File watcher handle (kept alive across reloads)
local watcher = nil

local function start_watcher()
	if watcher then return end

	local handle = vim.uv.new_fs_event()
	if not handle then return end

	handle:start(
		scheme_path,
		{},
		vim.schedule_wrap(function(err)
			if err then return end
			if vim.g.colors_name ~= "caelestia" then
				handle:stop()
				handle:close()
				watcher = nil
				return
			end
			local c = read_scheme()
			if c then apply(c) end
		end)
	)
	watcher = handle
end

function M.load()
	local c = read_scheme()
	apply(c)
	if c then
		start_watcher()
	end
end

M.load()

return M
