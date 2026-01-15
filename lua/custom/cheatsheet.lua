-- Custom Cheatsheet Module (NvChad-style)
local M = {}

-- Cheatsheet data organized by category
local cheatsheet_data = {
  {
    name = "General",
    icon = "",
    mappings = {
      { ";", "Enter command mode" },
      { "<Esc>", "Clear search highlights" },
      { "jk", "Exit insert mode" },
      { "<C-s>", "Save file" },
    },
  },
  {
    name = "Navigation",
    icon = "",
    mappings = {
      { "<C-h>", "Move to left window/tmux" },
      { "<C-j>", "Move to lower window/tmux" },
      { "<C-k>", "Move to upper window/tmux" },
      { "<C-l>", "Move to right window/tmux" },
      { "<C-d>", "Scroll down (centered)" },
      { "<C-u>", "Scroll up (centered)" },
      { "n", "Next search result (centered)" },
      { "N", "Previous search result (centered)" },
    },
  },
  {
    name = "Windows",
    icon = "",
    mappings = {
      { "<C-Up>", "Increase window height" },
      { "<C-Down>", "Decrease window height" },
      { "<C-Left>", "Decrease window width" },
      { "<C-Right>", "Increase window width" },
    },
  },
  {
    name = "Buffers",
    icon = "",
    mappings = {
      { "<Tab>", "Next buffer" },
      { "<S-Tab>", "Previous buffer" },
      { "<leader>x", "Close buffer" },
      { "<leader>b", "New buffer" },
    },
  },
  {
    name = "File Explorer",
    icon = "",
    mappings = {
      { "<leader>ee", "Toggle file tree" },
      { "<leader>ef", "Focus file tree" },
      { "<C-n>", "Toggle file tree" },
    },
  },
  {
    name = "Telescope",
    icon = "",
    mappings = {
      { "<leader>ff", "Find files" },
      { "ff", "Quick find files" },
      { "<leader>fw", "Live grep" },
      { "<leader>fb", "Find buffers" },
      { "<leader>fh", "Help tags" },
      { "<leader>fo", "Recent files" },
      { "<leader>fz", "Find in buffer" },
      { "<leader>ft", "Find TODOs" },
      { "<leader>fs", "Find symbols" },
    },
  },
  {
    name = "LSP",
    icon = "",
    mappings = {
      { "gd", "Go to definition" },
      { "gD", "Go to declaration" },
      { "gi", "Go to implementation" },
      { "gr", "Go to references" },
      { "<leader>k", "Hover documentation" },
      { "gk", "Signature help" },
      { "<leader>D", "Type definition" },
      { "<leader>rn", "Rename symbol" },
      { "<leader>ca", "Code action" },
      { "<leader>e", "Open diagnostic float" },
      { "<leader>q", "Diagnostic loclist" },
      { "[d", "Previous diagnostic" },
      { "]d", "Next diagnostic" },
      { "<leader>fm", "Format file" },
    },
  },
  {
    name = "Git",
    icon = "",
    mappings = {
      { "<leader>cm", "Git commits" },
      { "<leader>gt", "Git status" },
      { "<leader>lg", "LazyGit" },
      { "]c", "Next hunk" },
      { "[c", "Previous hunk" },
      { "<leader>hs", "Stage hunk" },
      { "<leader>hr", "Reset hunk" },
      { "<leader>hS", "Stage buffer" },
      { "<leader>hu", "Undo stage hunk" },
      { "<leader>hR", "Reset buffer" },
      { "<leader>hp", "Preview hunk" },
      { "<leader>hb", "Blame line" },
      { "<leader>hd", "Diff this" },
    },
  },
  {
    name = "Workspace",
    icon = "",
    mappings = {
      { "<leader>wa", "Add workspace folder" },
      { "<leader>wr", "Remove workspace folder" },
      { "<leader>wl", "List workspace folders" },
    },
  },
  {
    name = "Harpoon",
    icon = "󰛢",
    mappings = {
      { "<leader>a", "Add file to harpoon" },
      { "<C-e>", "Toggle harpoon menu" },
      { "<leader>1", "Harpoon file 1" },
      { "<leader>2", "Harpoon file 2" },
      { "<leader>3", "Harpoon file 3" },
      { "<leader>4", "Harpoon file 4" },
    },
  },
  {
    name = "Trouble",
    icon = "",
    mappings = {
      { "<leader>xx", "Diagnostics (Trouble)" },
      { "<leader>xX", "Buffer diagnostics" },
      { "<leader>cs", "Symbols (Trouble)" },
      { "<leader>cl", "LSP definitions" },
      { "<leader>xL", "Location list" },
      { "<leader>xQ", "Quickfix list" },
    },
  },
  {
    name = "Build & Run",
    icon = "",
    mappings = {
      { "<F5>", "Run code/application (.envrc)" },
      { "<F7>", "Build project (.envrc)" },
      { "<F8>", "Post-build script (.envrc)" },
    },
  },
  {
    name = "Visual Mode",
    icon = "",
    mappings = {
      { "<", "Indent left (keep selection)" },
      { ">", "Indent right (keep selection)" },
      { "J", "Move line down" },
      { "K", "Move line up" },
    },
  },
  {
    name = "Search & Replace",
    icon = "",
    mappings = {
      { "<leader>fr", "Find and replace (Spectre)" },
    },
  },
  {
    name = "Line Numbers",
    icon = "",
    mappings = {
      { "<leader>nn", "Toggle line numbers" },
      { "<leader>nr", "Toggle relative numbers" },
    },
  },
}

-- State
local state = {
  buf = nil,
  win = nil,
}

-- Highlight groups
local function setup_highlights()
  vim.api.nvim_set_hl(0, "CheatsheetHeader", { fg = "#7aa2f7", bold = true })
  vim.api.nvim_set_hl(0, "CheatsheetSection", { fg = "#bb9af7", bold = true })
  vim.api.nvim_set_hl(0, "CheatsheetKey", { fg = "#9ece6a" })
  vim.api.nvim_set_hl(0, "CheatsheetDesc", { fg = "#c0caf5" })
  vim.api.nvim_set_hl(0, "CheatsheetBorder", { fg = "#565f89" })
end

-- Build the cheatsheet content
local function build_content()
  local lines = {}
  local highlights = {}

  -- Header
  table.insert(lines, "")
  table.insert(lines, "   Neovim Cheatsheet")
  table.insert(highlights, { line = 2, col = 0, end_col = -1, hl = "CheatsheetHeader" })
  table.insert(lines, "   Press 'q' or <Esc> to close")
  table.insert(lines, "")
  table.insert(lines, string.rep("─", 60))
  table.insert(lines, "")

  local line_num = 7

  for _, section in ipairs(cheatsheet_data) do
    -- Section header
    local section_line = string.format("  %s %s", section.icon, section.name)
    table.insert(lines, section_line)
    table.insert(highlights, { line = line_num, col = 0, end_col = -1, hl = "CheatsheetSection" })
    table.insert(lines, "")
    line_num = line_num + 2

    -- Mappings
    for _, mapping in ipairs(section.mappings) do
      local key = mapping[1]
      local desc = mapping[2]
      -- Pad key to 16 chars for alignment
      local padded_key = string.format("%-16s", key)
      local mapping_line = string.format("    %s  %s", padded_key, desc)
      table.insert(lines, mapping_line)
      table.insert(highlights, { line = line_num, col = 4, end_col = 20, hl = "CheatsheetKey" })
      table.insert(highlights, { line = line_num, col = 22, end_col = -1, hl = "CheatsheetDesc" })
      line_num = line_num + 1
    end

    table.insert(lines, "")
    line_num = line_num + 1
  end

  return lines, highlights
end

-- Create the floating window
local function create_window()
  local width = math.min(70, math.floor(vim.o.columns * 0.8))
  local height = math.min(40, math.floor(vim.o.lines * 0.8))
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create buffer
  state.buf = vim.api.nvim_create_buf(false, true)
  vim.bo[state.buf].buftype = "nofile"
  vim.bo[state.buf].bufhidden = "wipe"
  vim.bo[state.buf].swapfile = false
  vim.bo[state.buf].filetype = "cheatsheet"

  -- Create window
  state.win = vim.api.nvim_open_win(state.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Cheatsheet ",
    title_pos = "center",
  })

  -- Window options
  vim.wo[state.win].wrap = false
  vim.wo[state.win].cursorline = true
  vim.wo[state.win].number = false
  vim.wo[state.win].relativenumber = false
  vim.wo[state.win].signcolumn = "no"
end

-- Apply highlights
local function apply_highlights(highlights)
  local ns = vim.api.nvim_create_namespace("cheatsheet")
  for _, hl in ipairs(highlights) do
    pcall(vim.api.nvim_buf_add_highlight, state.buf, ns, hl.hl, hl.line - 1, hl.col, hl.end_col)
  end
end

-- Set keymaps for the buffer
local function set_buffer_keymaps()
  local opts = { buffer = state.buf, noremap = true, silent = true }
  vim.keymap.set("n", "q", M.close, opts)
  vim.keymap.set("n", "<Esc>", M.close, opts)
  vim.keymap.set("n", "<leader>ch", M.close, opts)
end

-- Open the cheatsheet
function M.open()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    return
  end

  setup_highlights()
  create_window()

  local lines, highlights = build_content()
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.bo[state.buf].modifiable = false

  apply_highlights(highlights)
  set_buffer_keymaps()
end

-- Close the cheatsheet
function M.close()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end
  state.win = nil
  state.buf = nil
end

-- Toggle the cheatsheet
function M.toggle()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    M.close()
  else
    M.open()
  end
end

return M
