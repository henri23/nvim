return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  keys = {
    { "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    { "<leader>ef", "<cmd>NvimTreeFocus<cr>", desc = "Focus file tree" },
    { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
  },
  opts = {
    filters = { dotfiles = false },
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    git = {
      enable = true,
      ignore = false,
    },
    view = {
      width = 30,
      preserve_window_proportions = true,
    },
    renderer = {
      root_folder_label = false,
      highlight_git = true,
      indent_markers = { enable = true },
      icons = {
        git_placement = "after",
        glyphs = {
          git = {
            unstaged = "●",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
  },
}
