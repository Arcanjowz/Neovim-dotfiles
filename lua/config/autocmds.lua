-- Defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
local autocmd = vim.api.nvim_create_autocmd

-- Indentação de 2 espaços para JS/TS/HTML/CSS/YAML/JSON/Lua
autocmd("FileType", {
  pattern = { "javascript", "typescript", "html", "css", "scss", "yaml", "json", "lua" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Highlight ao copiar
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Fecha o terminal ao sair do processo
autocmd("TermClose", {
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, { force = true })
    end
  end,
})
