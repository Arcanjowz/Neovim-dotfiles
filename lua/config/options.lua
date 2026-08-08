-- Defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true -- número relativo (ótimo para navegar com j/k)
vim.opt.scrolloff = 8 -- mantém 8 linhas de contexto ao rolar
vim.opt.tabstop = 4 -- tab = 4 espaços
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- usa espaços ao invés de tab
vim.opt.colorcolumn = "" -- guias de coluna (boas práticas de código)
vim.opt.wrap = false -- sem quebra de linha automática
vim.opt.termguicolors = true
--  ideias adicionadas, caso de problema remover tudo abaixo
vim.opt.number = true -- número absoluto na linha atual (junto com relativenumber fica ótimo)
vim.opt.signcolumn = "yes" -- reserva espaço pro LSP/git não ficar deslocando o texto
vim.opt.updatetime = 250 -- atualiza diagnósticos/git mais rápido (padrão é 4000ms)
vim.opt.splitright = true -- novo split vertical abre à direita
vim.opt.splitbelow = true -- novo split horizontal abre abaixo
vim.opt.ignorecase = true -- busca case-insensitive
vim.opt.smartcase = true -- mas se digitar maiúscula, respeita
vim.opt.cursorline = true -- destaca a linha do cursor
vim.opt.winborder = "rounded" -- borda arredondada em todas as janelas flutuantes (hover, diagnostics, autocomplete)
