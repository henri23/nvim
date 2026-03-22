local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
map("n", ";", ":", { desc = "Enter command mode" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Better escape
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("i", "<Esc>", "<Nop>") -- Disable Escape in insert mode

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window resize
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "New buffer" })

-- Save file
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })
map("n", "n", "nzzzv", { desc = "Next search result centered" })
map("n", "N", "Nzzzv", { desc = "Previous search result centered" })

-- Nvim-tree
map("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
map("n", "<leader>ef", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file tree" })
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })
map("n", "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Find symbols" })

-- Quick find files (bottom pane, no preview)
map("n", "ff", function()
  require("telescope.builtin").find_files({
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 0.20,
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    prompt_title = false,
    prompt_prefix = "",
    previewer = false,
    border = false,
  })
end, { desc = "Quick find files" })

-- LSP keymaps (set on LspAttach in lsp.lua, but also globally for convenience)
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gk", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type definition" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic loclist" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Formatting
map("n", "<leader>fm", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })

-- Spectre (find/replace)
map("n", "<leader>fr", function()
  require("spectre").open()
end, { desc = "Find and replace (Spectre)" })

-- Tmux navigator
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate right" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate up" })

-- Terminal (F10) - will be set in terminal plugin
-- Build keymaps (F5/F7/F8) are project-specific, defined in .nvim.lua files
-- Line numbers toggle
map("n", "<leader>nn", "<cmd>set number!<CR>", { desc = "Toggle line numbers" })
map("n", "<leader>nr", "<cmd>set relativenumber!<CR>", { desc = "Toggle relative numbers" })

-- Create file/folder relative to current buffer
map("n", "<leader>cf", function()
  local buf_dir = vim.fn.expand("%:p:h")
  vim.ui.input({ prompt = "Create (relative to " .. buf_dir .. "): " }, function(input)
    if not input or input == "" then
      return
    end
    local target = buf_dir .. "/" .. input
    if input:sub(-1) == "/" then
      vim.fn.mkdir(target, "p")
      vim.notify("Created directory: " .. target)
    else
      local dir = vim.fn.fnamemodify(target, ":h")
      vim.fn.mkdir(dir, "p")
      vim.cmd("edit " .. vim.fn.fnameescape(target))
    end
  end)
end, { desc = "Create file/folder from buffer dir" })

-- Harpoon keymaps - will be set in navigation plugin
-- Trouble keymaps - will be set in coding plugin
