return {
  -- Rust: experiência completa (inlay hints, run, test, etc.)
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = "rust",
  },

  -- Java: suporte completo ao jdtls (LSP + formatter nativo + debug)
  -- OBS: a ativação de fato acontece em ftplugin/java.lua (na raiz do
  -- config, ao lado de init.lua) — declarar o plugin com `ft` sozinho
  -- não inicia o servidor, é preciso chamar jdtls.start_or_attach().
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  -- Go: extras (tags, test, etc.)
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
    dependencies = { "ray-x/guihua.lua" },
    build = ':lua require("go.install").update_all_sync()',
    opts = {},
  },

  -- Treesitter: syntax highlighting para todas as linguagens
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "python",
        "javascript",
        "typescript",
        "tsx",
        "java",
        "c",
        "cpp",
        "go",
        "rust",
        "html",
        "css",
        "scss",
        "sql",
        "lua",
        "dockerfile",
        "yaml",
        "json",
        "toml",
        "bash",
        "markdown",
        "markdown_inline",
        "git_commit",
        "gitignore",
        "xml", -- pom.xml, formatter.xml (Java)
      })
    end,
  },
}
