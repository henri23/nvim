return {
  {
    "nickjvandyke/opencode.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "opencode_output" },
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
        },
      },
    },
    config = function()
      vim.o.autoread = true

      vim.g.opencode_opts = vim.tbl_deep_extend(
        "force",
        vim.g.opencode_opts or {},
        {}
      )

      local function opencode_call(
        method,
        ...
      )
        local ok, opencode = pcall(
          require,
          "opencode"
        )
        if not ok then
          vim.notify(
            "opencode.nvim is not available",
            vim.log.levels.ERROR,
            { title = "opencode" }
          )
          return
        end

        local fn = opencode[method]
        if type(fn) == "function" then
          return fn(...)
        end

        if method == "toggle" and type(opencode.start) == "function" then
          return opencode.start()
        end

        vim.notify(
          "opencode.nvim API mismatch: missing `" .. method .. "` (run :Lazy sync)",
          vim.log.levels.WARN,
          { title = "opencode" }
        )
      end

      vim.keymap.set(
        { "n", "x" },
        "<leader>oa",
        function()
          opencode_call(
            "ask",
            "@this: ",
            { submit = true }
          )
        end,
        { desc = "Ask opencode" }
      )

      vim.keymap.set(
        { "n", "x" },
        "<leader>os",
        function()
          opencode_call("select")
        end,
        { desc = "Select opencode action" }
      )

      vim.keymap.set(
        { "n", "t" },
        "<leader>oo",
        function()
          opencode_call("toggle")
        end,
        { desc = "Toggle opencode" }
      )
    end,
  },
}
