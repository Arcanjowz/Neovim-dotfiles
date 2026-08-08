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
        "biome", -- linter + formatter JS/TS (substitui prettierd + eslint)
        "prettierd", -- mantido como fallback para projetos legado

        -- Python
        "basedpyright", -- fork do pyright com type checking mais estrito
        "ruff", -- linter + formatter + organize imports

        -- Java
        "jdtls",
        "java-debug-adapter", -- integra jdtls com nvim-dap
        "java-test", -- runner de testes JUnit via jdtls

        -- C/C++
        "clangd",
        "clang-format",
        -- clang-tidy NÃO é um pacote separado do Mason: ele já faz parte
        -- do próprio clangd (LLVM). Basta a flag --clang-tidy no cmd do
        -- clangd (feito abaixo) para habilitá-lo — não precisa instalar nada aqui.

        -- Go
        "gopls",
        "gofumpt", -- formatter mais estrito que gofmt
        "golangci-lint", -- meta-linter padrão da comunidade Go (agrega 50+ linters)

        -- Rust
        "rust-analyzer",

        -- SQL
        "sqlls", -- substitui sqls (abandonado)

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

      -- DESATIVA O ATALHO 'K' PADRÃO DO LAZYVIM
      -- Na versão atual do LazyVim os keymaps de LSP vivem em servers['*'].keys,
      -- não em opts.keys solto (isso era do formato antigo e não tinha efeito).
      -- Isso impede que o keymap buffer-local padrão do LazyVim (que sempre
      -- ganha de um map global) compita com o "K" que require("util.lsp_hover")
      -- registra sozinho via LspAttach (ver config/keymaps.lua).
      opts.servers = opts.servers or {}
      opts.servers["*"] = opts.servers["*"] or {}
      opts.servers["*"].keys = opts.servers["*"].keys or {}
      table.insert(opts.servers["*"].keys, { "K", false })

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

      -- Biome LSP (linting em tempo real para JS/TS)
      opts.servers.biome = {}

      -- Python — basedpyright para type checking, ruff desativa hover pra não conflitar
      opts.servers.basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard", -- "off" | "basic" | "standard" | "strict"
            },
          },
        },
      }
      opts.servers.ruff = {}
      opts.setup = opts.setup or {}
      opts.setup["ruff"] = function(_, ruff_opts)
        -- Desativa hover do ruff: basedpyright já cuida disso com mais qualidade
        ruff_opts.on_attach = function(client)
          client.server_capabilities.hoverProvider = false
        end
        return false
      end

      -- C/C++ — habilita clang-tidy embutido no clangd para diagnósticos de lint
      -- (clangd roda o clang-tidy internamente, mais rápido que chamar o binário à parte)
      opts.servers.clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      }

      -- Go
      opts.servers.gopls = {}

      -- SQL — sqlls substituiu o sqls (abandonado)
      opts.servers.sqlls = {}

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

  -- Linter via nvim-lint (complementa o LSP com linters externos)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        go = { "golangcilint" }, -- meta-linter padrão da comunidade Go
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      }
      -- Roda o linter ao salvar e ao entrar no buffer
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- Fecha tags HTML automaticamente: digita <div> e fecha sozinho </div>
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- Autocompletion
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
      completion = {
        menu = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
          draw = { gap = 1 },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
            max_width = 60,
            max_height = 20,
          },
        },
        ghost_text = { enabled = true },
      },
    },
  },
}
