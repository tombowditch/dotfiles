local wezterm = require 'wezterm'
local act = wezterm.action

return {
  window_padding = { top = 0, bottom = 0, left = 0, right = 0 },
  font = wezterm.font({
    family = "Berkeley Mono",
  }),
  font_size = 13.5,
  color_scheme = "saturn",
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  send_composed_key_when_left_alt_is_pressed = true,
  send_composed_key_when_right_alt_is_pressed = false,
  use_ime = false,
  keys = {
    { key = "_", mods = "CTRL|SHIFT", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    { key = "W", mods = "CMD|SHIFT", action = act.CloseCurrentPane { confirm = true } },
    { key = "|", mods = "CTRL|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "A", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
    { key = "D", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
    { key = "S", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
    { key = "W", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
    { key = "LeftArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize { "Left", 5 } },
    { key = "RightArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize { "Right", 5 } },
    { key = "DownArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize { "Down", 5 } },
    { key = "UpArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize { "Up", 5 } },
    { key = "LeftArrow", mods = "CMD", action = act.ActivateTabRelative(-1) },
    { key = "RightArrow", mods = "CMD", action = act.ActivateTabRelative(1) },
    { key = "LeftArrow", mods = "CMD|SHIFT", action = act.MoveTabRelative(-1) },
    { key = "RightArrow", mods = "CMD|SHIFT", action = act.MoveTabRelative(1) },
  }

}
