return {
  -- Renderiza markdown direto no buffer (tabelas, negrito, etc.)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- Preview no browser (útil para visualização final)
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && npm install",
    cmd = { "MarkdownPreviewToggle" },
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview (browser)" },
    },
  },
}
