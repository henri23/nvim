return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- New nvim-treesitter (main branch) only handles parser installation
    -- Highlighting is handled by Neovim 0.11+ core via vim.treesitter.start()
    local ensure_installed = {
      "astro",
      "c",
      "cpp",
      "css",
      "glsl",
      "html",
      "lua",
      "luadoc",
      "printf",
      "rust",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "javascript",
      "json",
      "yaml",
      "python",
      "dockerfile",
      "cmake",
      "markdown",
      "markdown_inline",
      "c_sharp",
      "odin",
    }

    local installed = {}
    for _, parser in ipairs(vim.api.nvim_get_runtime_file("parser/*.so", true)) do
      installed[vim.fn.fnamemodify(parser, ":t:r")] = true
    end

    local missing = {}
    for _, lang in ipairs(ensure_installed) do
      if not installed[lang] then
        table.insert(missing, lang)
      end
    end

    if #missing > 0 then
      vim.cmd("TSInstall " .. table.concat(missing, " "))
    end
  end,
}
