return {
  -- Mason - LSP/DAP/Linter installer
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {
      ensure_installed = {
        -- Lua
        "lua-language-server",
        "stylua",
        -- C/C++
        "clangd",
        "clang-format",
        -- CMake
        "neocmakelsp",
        -- Rust
        "rust-analyzer",
        "rustfmt",
        -- GLSL
        "glsl_analyzer",
        -- TypeScript / JavaScript
        "typescript-language-server",
        "eslint-lsp",
        -- Astro
        "astro-language-server",
        -- Web
        "tailwindcss-language-server",
        "prettier",
        -- C#
        "roslyn",
        "csharpier",
        -- Python
        "python-lsp-server",
        "ruff",
        -- JSON / YAML / Docker
        "json-lsp",
        "yaml-language-server",
        "dockerfile-language-server",
        "docker-compose-language-service",
        -- OCaml
        -- NOTE: ocaml-lsp intentionally NOT managed by Mason.
        -- Mason ships a prebuilt ocamllsp binary tied to a specific OCaml
        -- compiler version; if the opam switch later downgrades (e.g. hardcaml
        -- pinning forced 5.4.1 -> 5.3.0), Mason's stale binary reports
        -- "Compiler version mismatch" on every cmi from the switch.
        -- We launch ocamllsp via `opam exec` instead (see ocamllsp config below)
        -- so the LSP binary always matches the active opam switch.
        "ocamlformat",
        -- VHDL (rust_hdl provides the vhdl_ls binary; vsg = formatter)
        "rust_hdl",
        "vhdl-style-guide",
        -- Verilog / SystemVerilog (verible provides both ls and format)
        "verible",
      },
    },
    config = function(_, opts)
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })
      -- Install ensure_installed packages
      local mr = require("mason-registry")
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },

  -- LSP Config using native vim.lsp.config (Neovim 0.11+)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Get capabilities from cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostic config (Neovim 0.11+ style)
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
        },
      })

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(event)
          local opts = { buffer = event.buf, noremap = true, silent = true }
          local map = vim.keymap.set

          map("n", "gD", vim.lsp.buf.declaration, opts)
          map("n", "gd", vim.lsp.buf.definition, opts)
          map("n", "K", vim.lsp.buf.hover, opts)
          map("n", "gi", vim.lsp.buf.implementation, opts)
          map("n", "gk", vim.lsp.buf.signature_help, opts)
          map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          map("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          map("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          map("n", "<leader>rn", vim.lsp.buf.rename, opts)
          map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          map("n", "gr", vim.lsp.buf.references, opts)
          map("n", "<leader>e", vim.diagnostic.open_float, opts)
          map("n", "[d", vim.diagnostic.goto_prev, opts)
          map("n", "]d", vim.diagnostic.goto_next, opts)
          map("n", "<leader>q", vim.diagnostic.setloclist, opts)
        end,
      })

      -- Configure LSP servers using vim.lsp.config (Neovim 0.11+)

      -- Lua LS
      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.fn.expand("$VIMRUNTIME/lua"),
                vim.fn.stdpath("config") .. "/lua",
              },
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
        capabilities = capabilities,
      }

      -- Clangd (C/C++)
      vim.lsp.config.clangd = {
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
        capabilities = capabilities,
      }

      -- GLSL Analyzer
      vim.lsp.config.glsl_analyzer = {
        cmd = { "glsl_analyzer" },
        filetypes = { "glsl", "vert", "frag" },
        root_markers = { ".git" },
        capabilities = capabilities,
      }

      -- OLS (Odin Language Server)
      vim.lsp.config.ols = {
        cmd = { "ols" },
        filetypes = { "odin" },
        root_markers = { "ols.json", ".git" },
        capabilities = capabilities,
      }

      -- CMake
      vim.lsp.config.neocmakelsp = {
        cmd = { "neocmakelsp", "stdio" },
        filetypes = { "cmake" },
        root_markers = { "CMakeLists.txt", "cmake", ".git" },
        capabilities = capabilities,
      }

      -- Rust (used by rustaceanvim)
      vim.lsp.config["rust-analyzer"] = {
        capabilities = capabilities,
      }

      -- TypeScript / JavaScript
      vim.lsp.config.ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_markers = { "tsconfig.json", "package.json", ".git" },
        capabilities = capabilities,
      }

      -- Astro
      vim.lsp.config.astro = {
        cmd = { "astro-ls", "--stdio" },
        filetypes = { "astro" },
        root_markers = { "astro.config.mjs", "astro.config.ts", "package.json", ".git" },
        init_options = {
          typescript = {
            tsdk = vim.fs.joinpath(
              vim.fn.getcwd(),
              "node_modules",
              "typescript",
              "lib"
            ),
          },
        },
        capabilities = capabilities,
      }

      -- Tailwind CSS
      vim.lsp.config.tailwindcss = {
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = { "typescriptreact", "javascriptreact", "html", "css", "astro" },
        root_markers = { "tailwind.config.ts", "tailwind.config.js", ".git" },
        capabilities = capabilities,
      }

      -- ESLint
      vim.lsp.config.eslint = {
        cmd = { "vscode-eslint-language-server", "--stdio" },
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "astro" },
        root_markers = { "eslint.config.js", ".eslintrc.json", ".eslintrc.js", ".git" },
        capabilities = capabilities,
      }

      -- JSON
      vim.lsp.config.jsonls = {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = { ".git" },
        capabilities = capabilities,
      }

      -- YAML
      vim.lsp.config.yamlls = {
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml", "yml" },
        root_markers = { ".git" },
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose*.yml",
            },
          },
        },
      }

      -- Python (pylsp / Jedi)
      vim.lsp.config.pylsp = {
        cmd = { "pylsp" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
        capabilities = capabilities,
      }

      -- Ruff (Python linter/formatter)
      vim.lsp.config.ruff = {
        cmd = { "ruff", "server" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
        capabilities = capabilities,
      }

      -- Dockerfile
      vim.lsp.config.dockerls = {
        cmd = { "docker-langserver", "--stdio" },
        filetypes = { "dockerfile" },
        root_markers = { "Dockerfile", ".git" },
        capabilities = capabilities,
      }

      -- OCaml (ocaml-lsp-server)
      -- Launched via `opam exec` so the ocamllsp binary ALWAYS comes from the
      -- active opam switch and cannot be shadowed by a stale Mason-managed
      -- prebuilt. This prevents the "Compiler version mismatch" error that
      -- happens when Mason's bundled ocamllsp targets a different OCaml
      -- compiler version than the one currently installed in opam.
      vim.lsp.config.ocamllsp = {
        cmd = { "opam", "exec", "--", "ocamllsp" },
        filetypes = {
          "ocaml",
          "ocaml.menhir",
          "ocaml.interface",
          "ocaml.ocamllex",
          "reason",
          "dune",
        },
        root_markers = {
          "*.opam",
          "esy.json",
          "package.json",
          "dune-project",
          "dune-workspace",
          ".git",
        },
        capabilities = capabilities,
      }

      -- VHDL (rust_hdl / vhdl_ls) - also handles formatting
      vim.lsp.config.vhdl_ls = {
        cmd = { "vhdl_ls" },
        filetypes = { "vhdl" },
        root_markers = { "vhdl_ls.toml", ".git" },
        capabilities = capabilities,
      }

      -- Verilog / SystemVerilog (Verible)
      vim.lsp.config.verible = {
        cmd = { "verible-verilog-ls", "--rules_config_search" },
        filetypes = { "verilog", "systemverilog" },
        root_markers = { ".rules.verible_lint", ".git" },
        capabilities = capabilities,
      }

      if vim.g.project_disable_lsp then
        return
      end

      -- Enable the LSP servers
      vim.lsp.enable({
        "lua_ls",
        "clangd",
        "glsl_analyzer",
        "ols",
        "neocmakelsp",
        "ts_ls",
        "astro",
        "tailwindcss",
        "eslint",
        "jsonls",
        "yamlls",
        "pylsp",
        "ruff",
        "dockerls",
        "ocamllsp",
        "vhdl_ls",
        "verible",
      })
    end,
  },
}
