return {
  {
    "mrcjkb/rustaceanvim",
    version = "^8",
    lazy = false,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
    config = function(_, opts)
      require("crates").setup(opts)

      vim.api.nvim_create_autocmd(
        { "BufReadPost", "BufNewFile" },
        {
          group = vim.api.nvim_create_augroup(
            "RustCratesKeymaps",
            { clear = true }
          ),
          pattern = "Cargo.toml",
          callback = function(event)
            local map = vim.keymap.set

            map(
              "n",
              "<leader>ct",
              function()
                require("crates").toggle()
              end,
              { buffer = event.buf, silent = true, desc = "Toggle crate info" }
            )

            map(
              "n",
              "<leader>cp",
              function()
                require("crates").show_popup()
              end,
              { buffer = event.buf, silent = true, desc = "Show crate popup" }
            )

            map(
              "n",
              "<leader>cv",
              function()
                require("crates").show_versions_popup()
              end,
              { buffer = event.buf, silent = true, desc = "Show crate versions" }
            )

            map(
              "n",
              "<leader>cu",
              function()
                require("crates").update_crate()
              end,
              { buffer = event.buf, silent = true, desc = "Update crate" }
            )
          end,
        }
      )
    end,
  },
}
