-- Vim Options
local opt = vim.opt
local o = vim.o

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300

-- UI
opt.number = false
opt.relativenumber = false
opt.cursorline = true
o.cursorlineopt = "both"
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.termguicolors = true
opt.showmode = false
opt.laststatus = 3
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Tabs & Indentation (defaults, C++ overrides below)
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Disable line wrapping
opt.wrap = true

-- Fill chars
opt.fillchars = { eob = " " }

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- PowerShell as default shell (Windows)
if vim.fn.has("win32") == 1 then
	opt.shell = "powershell.exe"
	opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
	opt.shellquote = ""
	opt.shellxquote = ""
end

-- Neovide settings
if vim.g.neovide then
	vim.o.guifont = "Liberation Mono:h14"
	vim.g.neovide_opacity = 0.95
	vim.g.neovide_normal_opacity = 0.95
	vim.o.termguicolors = true

end

-- Disable some built-in providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
