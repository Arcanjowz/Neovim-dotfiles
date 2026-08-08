-- Defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

-- OBS: <leader>r roda o arquivo atual via um runner caseiro construído em cima
-- do toggleterm.nvim (ver lua/plugins/runner.lua). Não usamos nenhum plugin de
-- runner externo (ex.: code_runner.nvim). Se um dia crescer para mais de um
-- comando (rodar projeto, rodar testes, parar), migrar para um namespace tipo
-- <leader>rr/<leader>rt/<leader>rc para não repetir a ambiguidade de prefixo
-- que <leader>l/<leader>ls tinha (ver liveserver.lua).

-- OBS: a navegação entre splits com <C-hjkl> foi removida daqui porque é
-- idêntica ao default do LazyVim (config/keymaps.lua da LazyVim), com a
-- diferença de que o default usa remap = true e este aqui não. Sem
-- remap = true, uma futura integração com plugin tipo tmux-navigator pode
-- quebrar por não permitir remapeamento recursivo. O LazyVim já cobre isso,
-- então deixamos o default original valer.

-- Move linhas selecionadas com Shift+J/K no visual
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move seleção abaixo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move seleção acima" })

-- Mantém o cursor no centro ao rolar
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- OBS: o "colar sem sobrescrever o clipboard" em modo visual (map("v", "p", '"_dP'))
-- foi removido daqui de propósito. Esse mapeamento é global e carrega depois do
-- <Plug>(YankyPutAfter) que o yanky.nvim registra em modo visual (editor.lua),
-- então sempre vencia e matava o highlight de "put" e o yank-cycle do yanky em
-- qualquer colagem sobre seleção. Se algum dia você preferir voltar a esse
-- comportamento, tire o "p"/"P" do bloco `keys` do yanky.nvim em vez de
-- reintroduzir esse mapeamento aqui, senão o conflito volta.

-- OBS: "Ver diagnóstico" já existe como <leader>cd (padrão do LazyVim,
-- "Line Diagnostics"). O <leader>xd que existia aqui era uma duplicata da
-- mesma ação em outra tecla — removido para evitar dois binds fazendo a
-- mesma coisa. Use <leader>cd.

-- OBS: a tecla K para o Hover Fancy NÃO é mapeada aqui. O módulo
-- lua/util/lsp_hover.lua se auto-configura chamando .setup() logo abaixo: ele
-- já registra o keymap "K" sozinho, buffer-local, via autocmd LspAttach, e
-- troca o handler global de textDocument/hover. Um map("n", "K", ...) manual
-- aqui seria redundante e concorreria com o buffer-local do próprio módulo.
--
-- Fica em keymaps.lua (em vez de dentro de um plugin spec em lua/plugins/)
-- porque este arquivo é carregado automaticamente UMA VEZ pelo core do
-- LazyVim no startup — é o lugar certo para chamar setup() de um módulo
-- puro. Colocar esse arquivo dentro de lua/plugins/ quebra o lazy.nvim: todo
-- .lua ali é escaneado como plugin spec (por causa do `{ import = "plugins" }`
-- em config/lazy.lua), e uma tabela com `hover = <function>` não é um spec
-- válido — é exatamente o erro "Invalid plugin spec" que aparecia antes.
require("util.lsp_hover").setup()
