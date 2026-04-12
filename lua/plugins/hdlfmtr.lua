return {
  "henri23/hdlfmtr",
  build = "cargo build --release",
  ft = "vhdl",
  dependencies = { "stevearc/conform.nvim" },
  config = function()
    require("hdlfmtr").setup({
      -- Leave false: formatting.lua already lists hdlfmtr explicitly
      -- in formatters_by_ft.vhdl, so we don't need the plugin to
      -- silently mutate conform's config at runtime.
      auto_register_vhdl = false,
    })
  end,
}
