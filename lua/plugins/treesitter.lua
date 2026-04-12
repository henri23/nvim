return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- nvim-treesitter main branch only handles parser installation.
    -- Highlighting is handled by Neovim 0.11+ core via vim.treesitter.start()
    -- (see lua/autocmds.lua for the FileType autocmd that calls it).
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
      "ocaml",
      "ocaml_interface",
      "systemverilog",
      "vhdl",
    }

    local nts = require("nvim-treesitter")
    nts.setup()

    local installed = {}
    for _, lang in ipairs(nts.get_installed()) do
      installed[lang] = true
    end

    local missing = {}
    for _, lang in ipairs(ensure_installed) do
      if not installed[lang] then
        table.insert(missing, lang)
      end
    end

    if #missing > 0 then
      nts.install(missing)
    end
  end,
}
