return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    smear_to_cmd = true,

    smear_horizontally = true,
    smear_vertically = true,
    smear_diagonally = true,

    min_horizontal_distance_smear = 0,
    min_vertical_distance_smear = 0,

    smear_insert_mode = true,
    vertical_bar_cursor_insert_mode = true,
    vertical_bar_cursor = false,

    smear_replace_mode = false,
    smear_terminal_mode = false,

    stiffness = 0.6,
    trailing_stiffness = 0.3,
    damping = 0.8,
    trailing_exponent = 4,
    anticipation = 0.2,
    distance_stop_animating = 0.1,
    max_length = 30,

    stiffness_insert_mode = 0.5,
    trailing_stiffness_insert_mode = 0.4,
    damping_insert_mode = 0.85,
    trailing_exponent_insert_mode = 2,

    time_interval = 17,
    delay_event_to_smear = 1,
    delay_after_key = 5,

    cursor_color = "none",
    gradient_exponent = 1.0,
    never_draw_over_target = false,
    hide_target_hack = false,
    legacy_computing_symbols_support = false,

    filetypes_disabled = { "alpha", "dashboard", "TelescopePrompt" },
  },
}
