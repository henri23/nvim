return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format file",
    },
  },
  opts = {
    formatters_by_ft = {
      -- Lua
      lua = { "stylua" },
      -- C/C++
      cpp = { "clang-format" },
      c = { "clang-format" },
      hpp = { "clang-format" },
      h = { "clang-format" },
      -- CMake
      cmake = { "gersemi" },
      -- Rust
      rust = { "rustfmt" },
      -- Web (prettier)
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      astro = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      -- C#
      cs = { "csharpier" },
      -- OCaml
      ocaml = { "ocamlformat" },
      -- Verilog / SystemVerilog (Verible)
      verilog = { "verible_verilog_format" },
      systemverilog = { "verible_verilog_format" },
      -- VHDL
      vhdl = { "hdlfmtr" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
