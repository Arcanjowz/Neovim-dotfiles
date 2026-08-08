return {
  -- Statusline customizada (config em lua/config/lualine.lua)
  {
    "nvim-lualine/lualine.nvim",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = " "
      else
        vim.o.laststatus = 0
      end
    end,
    config = function()
      require("config.lualine")
    end,
  },

  -- Mostra cores CSS inline (#ff0000 fica vermelho no editor)
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          css = true,
          html = true,
          tailwind = true,
          RRGGBB = true,
          rgb_fn = true,
          hsl_fn = true,
        },
      })
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          require("colorizer").attach_to_buffer(0)
        end,
      })
    end,
  },

  -- Color picker igual VSCode (abre com <leader>cp)
  {
    "uga-rosa/ccc.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color Picker" },
    },
    opts = {
      highlighter = {
        auto_enable = false, -- deixa só o colorizer fazer isso
        lsp = true,
      },
    },
  },

  -- Indentação visual (linhas guia)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
    },
  },
}
