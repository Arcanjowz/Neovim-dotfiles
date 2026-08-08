return {
  "barrettruth/live-server.nvim",
  -- ou, se preferir usar a fonte oficial (Forgejo):
  -- url = "https://git.barrettruth.com/barrettruth/live-server.nvim",
  cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
  init = function()
    vim.g.live_server = {
      port = 8080,
      browser = true, -- abre o navegador automaticamente
    }
  end,
  -- <leader>ls foi movido para <leader>rl: <leader>l sozinho já é o comando
  -- completo do LazyVim (abre :Lazy), então <leader>ls ficava ambíguo com
  -- ele (o Neovim esperava timeoutlen para decidir qual dos dois disparar).
  -- <leader>rl entra no mesmo espírito de "rodar algo" do runner caseiro
  -- (<leader>r, ver plugins/runner.lua).
  keys = {
    { "<leader>rl", "<cmd>LiveServerToggle<cr>", desc = "Toggle Live Server" },
  },
}
