return {
  "akinsho/toggleterm.nvim",
  version = "*",
  -- lazy = false removido: o campo `keys` abaixo já registra o mapeamento de
  -- <C-t> no startup (é assim que o lazy-loading por tecla do lazy.nvim
  -- funciona), então lazy = false só forçava o plugin inteiro a carregar cedo
  -- sem necessidade, deixando o startup um pouco mais lento à toa.
  keys = {
    { "<C-t>", "<cmd>ToggleTerm<cr>", desc = "Abrir Terminal" },
  },
  opts = {
    open_mapping = [[<C-t>]],
    direction = "float",
    float_opts = {
      border = "curved",
    },
  },
}
