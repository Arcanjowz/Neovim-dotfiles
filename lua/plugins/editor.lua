return {
  -- Destaca TODO/FIXME/HACK/NOTE nos comentários
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Comentários rápidos com gcc / gc+motion
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Git: blame inline, diff de hunks, navegação
  -- opts é função (não tabela fixa) para ESTENDER o on_attach padrão do
  -- LazyVim em vez de substituí-lo. Função não faz merge automático com
  -- vim.tbl_deep_extend como tabela faz, então uma tabela fixa aqui apagaria
  -- os binds padrão do LazyVim (]h/[h/]H/[H, <leader>ghs, <leader>ghr,
  -- <leader>ghS, <leader>ghu, <leader>ghR, <leader>ghp, <leader>ghb/<leader>ghB,
  -- <leader>ghd/<leader>ghD, o text-object ih). Ver:
  -- https://github.com/LazyVim/LazyVim/discussions/4790
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.current_line_blame = true
      opts.current_line_blame_opts = { delay = 500 }

      local default_on_attach = opts.on_attach
      opts.on_attach = function(bufnr)
        if default_on_attach then
          default_on_attach(bufnr)
        end
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end
        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gd", gs.diffthis, "Diff")
        -- <leader>gb removido daqui de propósito: já existem <leader>ghb
        -- (Blame Line) e <leader>ghB (Blame Buffer) vindos do LazyVim, sem
        -- conflito com o <leader>gb padrão (git log da linha via Snacks).
        -- ]h/[h também removidos: já vêm do on_attach padrão acima.
      end
      return opts
    end,
  },

  -- Diff side-by-side completo + histórico de commits
  -- :DiffviewOpen para ver diff do working tree
  -- :DiffviewFileHistory % para histórico do arquivo atual
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Diffview abrir" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Histórico do arquivo" },
      { "<leader>gX", "<cmd>DiffviewClose<cr>", desc = "Diffview fechar" },
    },
    opts = {},
  },

  -- Histórico de yanks: após colar com p, navegue com <C-n>/<C-p>
  -- "p"/"P" aqui cobrem modo normal E visual de propósito: é o lado escolhido
  -- do conflito com o antigo map("v", "p", '"_dP') de keymaps.lua (removido de
  -- lá). Se quiser voltar ao "colar sem perder clipboard" em modo visual,
  -- troque a linha de "p" abaixo por '"_dP' em vez de mexer em keymaps.lua.
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    opts = {
      ring = {
        history_length = 20,
        storage = "memory",
      },
    },
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Colar (yanky)" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Colar antes (yanky)" },
      { "<C-n>", "<Plug>(YankyCycleForward)", desc = "Próximo yank" },
      { "<C-p>", "<Plug>(YankyCycleBackward)", desc = "Yank anterior" },
    },
  },

  -- Sublinha todas as ocorrências da palavra sob o cursor
  {
    "nvim-mini/mini.cursorword",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
}
