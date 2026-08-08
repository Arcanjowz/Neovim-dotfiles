return {
  -- Mason: gerenciador de LSPs, linters e formatters
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- Web
        "html-lsp",
        "css-lsp",
        "emmet-language-server",
        "typescript-language-server",
        "prettierd", -- formatter JS/TS/HTML/CSS

        -- Python
        "pyright",
        "ruff", -- linter + formatter moderno para Python

        -- Java
        "jdtls",

        -- C/C++
        "clangd",
        "clang-format",

        -- Go
        "gopls",
        "gofumpt", -- formatter Go

        -- Rust
        "rust-analyzer",

        -- SQL
        "sqls",
        "sqlfluff", -- linter SQL

        -- DevOps / Infra
        "dockerfile-language-server",
        "docker-compose-language-service",
        "yaml-language-server",
        "bash-language-server",
        "shfmt", -- formatter shell
        "shellcheck", -- linter shell

        -- Lua (para editar o próprio nvim)
        "lua-language-server",
        "stylua",
      })
    end,
  },

  -- LSPConfig: configura cada LSP
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- Web
      opts.servers.html = {}
      opts.servers.cssls = {}
      opts.servers.emmet_language_server = {
        filetypes = {
          "html",
          "css",
          "scss",
          "sass",
          "javascriptreact",
          "typescriptreact",
        },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        },
      }
      opts.servers.ts_ls = {}

      -- Python
      opts.servers.pyright = {}

      -- C/C++
      opts.servers.clangd = {}

      -- Go
      opts.servers.gopls = {}

      -- SQL
      opts.servers.sqls = {}

      -- DevOps
      opts.servers.dockerls = {}
      opts.servers.docker_compose_language_service = {}
      opts.servers.yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
            },
          },
        },
      }
      opts.servers.bashls = {}

      -- Lua
      opts.servers.lua_ls = {}
    end,
  },

  -- Fecha tags HTML automaticamente: digita <div> e fecha sozinho </div>
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Tab>"] = { "accept", "fallback" },
      },
      sources = {
        per_filetype = {
          html = { "lsp", "snippets", "path" },
        },
      },
    },
  },
}
