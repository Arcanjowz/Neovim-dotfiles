return {
  -- nvim-dap: motor DAP (Debug Adapter Protocol) — o "cérebro" do debugger
  -- Repo oficial: https://github.com/mfussenegger/nvim-dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- mason-nvim-dap: instala e configura os adapters (codelldb, delve, etc.) via Mason
      -- Repo oficial: https://github.com/jay-babu/mason-nvim-dap.nvim
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason-org/mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- handlers = {} é essencial: sem isso a instalação automática não funciona
          handlers = {},
          ensure_installed = {
            "codelldb", -- C, C++, Rust
          },
          -- delve (Go) e python (debugpy) ficam a cargo dos plugins
          -- especializados abaixo, que gerenciam sua própria instalação
          automatic_installation = {
            exclude = { "delve", "python" },
          },
        },
      },

      -- nvim-dap-ui: painéis de variáveis, breakpoints, watch, call stack e console
      -- Repo oficial: https://github.com/rcarriga/nvim-dap-ui
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        keys = {
          {
            "<leader>du",
            function()
              require("dapui").toggle({})
            end,
            desc = "Dap UI",
          },
          {
            "<leader>de",
            function()
              require("dapui").eval()
            end,
            desc = "Eval",
            mode = { "n", "v" },
          },
        },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          -- Abre a UI automaticamente ao iniciar uma sessão de debug
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },

      -- nvim-dap-virtual-text: mostra o valor das variáveis inline, ao lado do código
      -- Repo oficial: https://github.com/theHamsta/nvim-dap-virtual-text
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- nvim-dap-python: configurações prontas para debugar Python (via debugpy)
      -- Repo oficial: https://github.com/mfussenegger/nvim-dap-python
      {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function()
          -- Usa o debugpy instalado pelo próprio Mason
          local path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python3"
          require("dap-python").setup(path)
        end,
      },

      -- nvim-dap-go: configurações prontas para debugar Go (via delve)
      -- Repo oficial: https://github.com/leoluz/nvim-dap-go
      {
        "leoluz/nvim-dap-go",
        ft = "go",
        opts = {},
      },
    },

    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Condição do breakpoint: "))
        end,
        desc = "Breakpoint condicional",
      },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Continue/Start",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Rodar última sessão",
      },
    },

    config = function()
      local dap = require("dap")

      -- Ícones dos sinais de breakpoint na coluna esquerda
      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      sign("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "DapStoppedLine", numhl = "" })
      sign("DapBreakpointRejected", { text = "✗", texthl = "DiagnosticError", linehl = "", numhl = "" })

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- C/C++ via codelldb (instalado pelo mason-nvim-dap acima)
      -- Referência oficial: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      local codelldb_launch = {
        name = "Launch arquivo",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Caminho do executável: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      }
      dap.configurations.c = { codelldb_launch }
      dap.configurations.cpp = { codelldb_launch }
      -- Rust já tem debug embutido via rustaceanvim (DapConfig)
    end,
  },
}
