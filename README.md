# nvim

<img width="2448" height="1378" alt="image" src="https://github.com/user-attachments/assets/2e3ef7ac-2db6-4083-8b45-8fd1655918ba" />

<img width="2448" height="1378" alt="image" src="https://github.com/user-attachments/assets/32435e10-5643-414d-8a01-8fbc8a830d6b" />



> Configuração pessoal do Neovim baseada em [LazyVim](https://lazyvim.org), com foco em desenvolvimento multi-linguagem, UI polida e fluxo de trabalho eficiente.

## Estrutura

```
nvim/
├── init.lua                  # Entrypoint — bootstraps o lazy.nvim
├── lazy-lock.json            # Lockfile dos plugins
├── lazyvim.json              # Metadados do LazyVim
└── lua/
    ├── config/
    │   ├── autocmds.lua      # Autocmds customizados
    │   ├── keymaps.lua       # Keymaps personalizados
    │   ├── lazy.lua          # Setup do lazy.nvim
    │   ├── lualine.lua       # Configuração da statusline
    │   └── options.lua       # Opções do editor
    └── plugins/
        ├── ascii.lua         # Header ASCII no dashboard
        ├── colorscheme.lua   # Tema: oldworld.nvim
        ├── editor.lua        # Git, yanky, comentários, TODO
        ├── example.lua       # Exemplos LazyVim (referência)
        ├── formatting.lua    # Formatadores via conform.nvim
        ├── languages.lua     # Plugins por linguagem + Treesitter
        ├── lsp.lua           # Mason + nvim-lspconfig + blink.cmp
        ├── markdown.lua      # Render + preview de Markdown
        ├── terminal.lua      # Terminal flutuante (toggleterm)
        ├── typr.lua          # Typing practice
        └── ui.lua            # Lualine, colorizer, color picker, indent
```

## Tema

**[oldworld.nvim](https://github.com/dgox16/oldworld.nvim)** — paleta escura de baixo contraste com tons terrosos e suaves.

## LSPs e Ferramentas (via Mason)

| Linguagem      | LSP                          | Formatter         | Linter       |
| -------------- | ---------------------------- | ----------------- | ------------ |
| HTML/CSS       | html-lsp, css-lsp, emmet-ls  | prettierd         | —            |
| JavaScript/TS  | typescript-language-server   | prettierd         | —            |
| Python         | pyright                      | ruff              | ruff         |
| Go             | gopls                        | gofumpt           | —            |
| Rust           | rust-analyzer                | rustfmt           | —            |
| C/C++          | clangd                       | clang-format      | —            |
| Java           | jdtls                        | —                 | —            |
| SQL            | sqls                         | sqlfluff          | sqlfluff     |
| Shell          | bash-language-server         | shfmt             | shellcheck   |
| Lua            | lua-language-server          | stylua            | —            |
| Docker/YAML    | dockerfile-ls, yamlls        | —                 | —            |

## Plugins de Destaque

**Editor**
- `gitsigns.nvim` — blame inline, navegação e preview de hunks
- `diffview.nvim` — diff side-by-side e histórico de commits
- `yanky.nvim` — histórico de yanks navegável com `<C-n>` / `<C-p>`
- `todo-comments.nvim` — destaque de TODO / FIXME / NOTE nos comentários
- `ts-comments.nvim` — comentários inteligentes por filetype
- `mini.cursorword` — sublinha ocorrências da palavra sob o cursor

**UI**
- `lualine.nvim` — statusline customizada
- `nvim-colorizer.lua` — preview de cores CSS inline no buffer
- `ccc.nvim` — color picker (`<leader>cp`)
- `indent-blankline.nvim` — guias de indentação com `│`

**Linguagens**
- `rustaceanvim` — suporte completo a Rust (inlay hints, run, test)
- `nvim-jdtls` — integração com jdtls para Java
- `go.nvim` — extras para Go (tags, testes, etc.)
- `nvim-ts-autotag` — fecha tags HTML/JSX automaticamente
- `nvim-treesitter` — syntax highlighting para 20+ linguagens

**Markdown**
- `render-markdown.nvim` — renderiza tabelas e formatação direto no buffer
- `markdown-preview.nvim` — preview no browser (`<leader>mp`)

**Terminal**
- `toggleterm.nvim` — terminal flutuante com borda curva (`<C-t>`)

## Keymaps Customizados

| Keymap           | Modo   | Ação                                          |
| ---------------- | ------ | --------------------------------------------- |
| `<leader>r`      | Normal | Roda o arquivo atual no terminal flutuante    |
| `<C-t>`          | Normal | Abre/fecha terminal flutuante                 |
| `<C-h/j/k/l>`   | Normal | Navega entre splits                           |
| `J` / `K`        | Visual | Move seleção para baixo / acima               |
| `<C-d>` / `<C-u>` | Normal | Scroll centralizado no cursor                |
| `p`              | Visual | Cola sem sobrescrever o clipboard             |
| `<leader>cp`     | Normal | Abre o color picker                           |
| `<leader>mp`     | Normal | Toggle Markdown Preview no browser            |
| `<leader>gD`     | Normal | Abre Diffview                                 |
| `<leader>gH`     | Normal | Histórico do arquivo atual                    |
| `<leader>xd`     | Normal | Abre diagnóstico flutuante do LSP             |
| `]h` / `[h`      | Normal | Próximo / anterior hunk do Git                |
| `<C-n>` / `<C-p>` | Normal | Navega no histórico de yanks                 |

O `<leader>r` suporta: Python, JavaScript, TypeScript, C, C++, Go, Rust, Shell/Bash.

## Opções Notáveis

- `relativenumber` + `number` — número relativo com absoluto na linha atual
- `scrolloff = 8` — 8 linhas de contexto ao rolar
- `tabstop/shiftwidth = 4`, `expandtab` — tabs como 4 espaços
- `updatetime = 250` — diagnósticos e blame mais rápidos
- `cursorline` — destaque da linha atual
- Splits abrem à direita e abaixo por padrão
- Busca `ignorecase` + `smartcase`

### Clipboard — WSL vs Linux nativo

O `options.lua` inclui uma configuração de clipboard via `win32yank.exe` para integrar o yank do Neovim com o clipboard do Windows no WSL2:

```lua
-- arrumar erro do xclip no wsl2
vim.g.clipboard = {
  name = "win32yank",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
  cache_enabled = 0,
}
```

> **⚠️ Linux nativo:** esse bloco é exclusivo do WSL2 e **deve ser removido** se você estiver rodando no Linux diretamente. No Linux, o Neovim usa `xclip`, `xsel` ou `wl-clipboard` (Wayland) automaticamente com `clipboard = "unnamedplus"` — sem configuração extra necessária.

## Instalação

```bash
# Faça backup da config atual se necessário
mv ~/.config/nvim ~/.config/nvim.bak

# Clone o repositório
git clone https://github.com/seu-usuario/nvim.git ~/.config/nvim

# Abra o Neovim — o lazy.nvim instala tudo automaticamente
nvim
```

> Os LSPs e ferramentas são instalados pelo Mason na primeira abertura. Pode levar alguns minutos.

## Requisitos

- Neovim `>= 0.10`
- Git
- Node.js (para LSPs de JS/TS e markdown-preview)
- Um Nerd Font instalado e configurado no terminal
