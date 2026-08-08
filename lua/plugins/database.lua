return {
  -- vim-dadbod: motor de conexão com bancos de dados (o "backend")
  -- Repo oficial: https://github.com/tpope/vim-dadbod
  -- Suporta Postgres, MySQL, SQLite, MongoDB, Redis, e vários outros via URL de conexão
  {
    "tpope/vim-dadbod",
    lazy = true,
  },

  -- vim-dadbod-ui: interface visual (sidebar) para navegar bancos, tabelas e salvar queries
  -- Repo oficial: https://github.com/kristijanhusak/vim-dadbod-ui
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    -- OBS: o prefixo <leader>d já é todo usado pelo debug.lua (nvim-dap: db, dB, du,
    -- de, dt, dr, dl). Por isso o dadbod usa <leader>D (maiúsculo) como namespace,
    -- pra não colidir com nenhum atalho de debug existente.
    keys = {
      { "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "Database UI" },
      { "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "Adicionar conexão" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Achar buffer da query" },
    },
    init = function()
      -- Usa ícones bonitinhos (precisa de nerd font, que você já tem configurado)
      vim.g.db_ui_use_nerd_fonts = 1

      -- Onde ficam salvas as conexões e queries salvas
      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"

      -- Mostra o resultado da query numa janela menor embaixo, sem ocupar a tela toda
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_winwidth = 40

      -- Executa a query automaticamente ao salvar o arquivo (:w)
      vim.g.db_ui_execute_on_save = false
    end,
  },

  -- kristijanhusak/vim-dadbod-completion: autocomplete de nomes de tabela/coluna
  -- dentro de arquivos .sql, integrado ao blink.cmp/nvim-cmp automaticamente
  -- (já declarado como dependência acima, só documentando aqui)
}
