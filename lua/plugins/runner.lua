return {
  "akinsho/toggleterm.nvim",
  keys = {
    {
      "<leader>r",
      function()
        -- 1. Salva o arquivo atual automaticamente antes de executar
        vim.cmd("silent! write")

        local ft = vim.bo.filetype
        local file = vim.fn.expand("%:p")
        local dir = vim.fn.expand("%:p:h")
        local name_no_ext = vim.fn.expand("%:t:r")

        -- 2. Detecta ambiente virtual (.venv ou venv) para Python
        local function get_python_bin()
          if vim.fn.executable(dir .. "/.venv/bin/python") == 1 then
            return dir .. "/.venv/bin/python"
          elseif vim.fn.executable(dir .. "/venv/bin/python") == 1 then
            return dir .. "/venv/bin/python"
          end
          return "python3"
        end

        local py_bin = get_python_bin()

        -- 3. Mapeamento de linguagens com verificação de erros
        local cmds = {
          python = py_bin .. " -u " .. file,
          javascript = "node " .. file,
          typescript = "npx ts-node " .. file,
          c = "gcc -Wall -Wextra " .. file .. " -o /tmp/out && /tmp/out",
          cpp = "g++ -Wall -Wextra " .. file .. " -o /tmp/out && /tmp/out",
          go = "go run " .. file,
          rust = "rustc " .. file .. " -o /tmp/out && /tmp/out",
          java = "javac " .. file .. " && java -cp " .. dir .. " " .. name_no_ext,
          php = "php " .. file,
          ruby = "ruby " .. file,
          lua = "lua " .. file,
          sh = "bash " .. file,
          bash = "bash " .. file,
        }

        local cmd = cmds[ft]
        if cmd then
          local Terminal = require("toggleterm.terminal").Terminal
          local runner = Terminal:new({
            cmd = cmd
              .. "; code=$?; echo; if [ $code -eq 0 ]; then echo '✓ Concluído com sucesso (Exit Code: 0)'; else echo '✗ Falha na execução ou compilação (Exit Code: '$code')'; fi; echo 'Pressione Enter para fechar...'; read",
            close_on_exit = true,
            direction = "float",
            float_opts = {
              border = "curved",
            },
          })
          runner:toggle()
        else
          vim.notify("Linguagem não suportada: " .. ft, vim.log.levels.WARN)
        end
      end,
      desc = "Rodar arquivo atual com verificações",
    },
  },
}
