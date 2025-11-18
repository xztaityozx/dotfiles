local wezterm = require('wezterm')

return {
  font = wezterm.font("HackGen Console NF"),
  color_scheme = 'iceberg-dark',
  font_size = 18,
  use_ime = true,
  hide_tab_bar_if_only_one_tab = true,
  bold_brightens_ansi_colors = true,
  window_padding = { top = 0, bottom = 0, left = 0, right = 0 },
  keys = {
    { key = "q",  mods = "CTRL",    action = wezterm.action { SendString = "\x11" } },
    { key = "¥",  mods = "ALT|OPT", action = wezterm.action { SendString = "\\" } },
    { key = "F3", mods = "SHIFT",   action = wezterm.action.Nop }
  },
  quick_select_patterns = {
    '\\w+(?:::\\w+)+', -- Perl, Rust, C++ style namespaces and functions
  }
}
