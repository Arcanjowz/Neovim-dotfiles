return {
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
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      options = {
        parsers = {
          css = true,
          tailwind = { enable = true },
          xterm = { enable = true },
        },
        display = {
          mode = { "foreground", "virtualtext" },
          virtualtext = {
            char = "■",
            position = "before",
            hl_mode = "foreground",
          },
        },
      },
    },
  },
  {
    "uga-rosa/ccc.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color Picker" },
    },
    opts = {
      highlighter = {
        auto_enable = false,
        lsp = false,
      },
    },
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      {
        "<leader>v",
        function()
          require("oklch-color-picker").pick_under_cursor()
        end,
        desc = "Color Picker (mouse, OKLCH)",
      },
    },
    opts = {
      highlight = {
        enabled = false,
      },
    },
  },
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
