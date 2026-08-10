return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    local neoscroll = require("neoscroll")

    neoscroll.setup({
      mappings = {
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      duration_multiplier = 1.0,
      easing = "sine",
      performance_mode = false,
    })

    local keymap = {
      ["<C-u>"] = function()
        neoscroll.ctrl_u({ duration = 200 })
      end,
      ["<C-d>"] = function()
        neoscroll.ctrl_d({ duration = 200 })
      end,
      ["<C-b>"] = function()
        neoscroll.ctrl_b({ duration = 350 })
      end,
      ["<C-f>"] = function()
        neoscroll.ctrl_f({ duration = 350 })
      end,
      ["<C-y>"] = function()
        neoscroll.scroll(-0.10, { move_cursor = false, duration = 100 })
      end,
      ["<C-e>"] = function()
        neoscroll.scroll(0.10, { move_cursor = false, duration = 100 })
      end,
      ["zt"] = function()
        neoscroll.zt({ half_win_duration = 200 })
      end,
      ["zz"] = function()
        neoscroll.zz({ half_win_duration = 200 })
      end,
      ["zb"] = function()
        neoscroll.zb({ half_win_duration = 200 })
      end,

      ["<ScrollWheelUp>"] = function()
        neoscroll.scroll(-3, { move_cursor = false, duration = 100 })
      end,
      ["<ScrollWheelDown>"] = function()
        neoscroll.scroll(3, { move_cursor = false, duration = 100 })
      end,
    }

    local modes = { "n", "v", "x" }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
