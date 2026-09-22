-- ~/.wezterm.lua  (or ~/.config/wezterm/wezterm.lua)
-- WezTerm config for WSL + Neovim (LazyVim) + tmux web-dev workflow.
-- Theme: Tokyo Night | Font: VictorMono Nerd Font | Default: launches into WSL.

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

--------------------------------------------------------------------------------
-- WSL: launch straight into your distro
--------------------------------------------------------------------------------
-- WezTerm auto-creates a domain per installed distro, named "WSL:<DistroName>".
-- Run `wsl -l -q` in PowerShell to see your exact distro name, then set it here.
-- Common values: "WSL:Ubuntu", "WSL:Ubuntu-22.04", "WSL:Debian".
config.wsl_domains = {
  {
    name = "WSL:Ubuntu",
    distribution = "Ubuntu",
    default_cwd = "//wsl.localhost/Ubuntu/home/spencer/p/rs5",
  },
}
config.default_domain = "WSL:Ubuntu"

--------------------------------------------------------------------------------
-- Appearance
--------------------------------------------------------------------------------
config.color_scheme = "Tokyo Night"

config.font = wezterm.font_with_fallback({
  { family = "VictorMono Nerd Font" },
  "Symbols Nerd Font Mono", -- glyph fallback
})
config.font_size = 12.0
config.line_height = 1.05
config.cell_width = 1.0

-- No manual font_rules: WezTerm automatically synthesizes/selects the bold and
-- italic variants from the primary family above. If you want true italics, just
-- make sure the Italic + BoldItalic .ttf files from the VictorMono Nerd Font
-- download are also installed in Windows (not only the Regular file).

config.window_background_opacity = 0.97
config.window_decorations = "RESIZE" -- borderless; always-visible tab bar is the drag area
config.window_padding = { left = 6, right = 6, top = 6, bottom = 4 }
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false

--------------------------------------------------------------------------------
-- Tabs (kept subtle since tmux usually handles your tabs/panes)
--------------------------------------------------------------------------------
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false -- ponytail: always show it — it's the only drag/resize surface
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = false

--------------------------------------------------------------------------------
-- Performance / behavior
--------------------------------------------------------------------------------
config.max_fps = 120
config.animation_fps = 60
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.audible_bell = "Disabled"
config.default_cursor_style = "BlinkingBar"

--------------------------------------------------------------------------------
-- Keybindings
--------------------------------------------------------------------------------
-- Leader = CTRL+`. Avoids macOS's CTRL+SPACE language-switch shortcut.
config.leader = { key = "`", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
  -- Panes (split)
  { key = "\\", mods = "LEADER",       action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-",  mods = "LEADER",       action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "x",  mods = "LEADER",       action = act.CloseCurrentPane({ confirm = true }) },
  { key = "z",  mods = "LEADER",       action = act.TogglePaneZoomState },

  -- Pane navigation (hjkl)
  { key = "h",  mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
  { key = "j",  mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
  { key = "k",  mods = "LEADER",       action = act.ActivatePaneDirection("Up") },
  { key = "l",  mods = "LEADER",       action = act.ActivatePaneDirection("Right") },

  -- Pane resize
  { key = "H",  mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "J",  mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
  { key = "K",  mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
  { key = "L",  mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },

  -- Tabs
  { key = "c",  mods = "LEADER",       action = act.SpawnTab("CurrentPaneDomain") },
  { key = "n",  mods = "LEADER",       action = act.ActivateTabRelative(1) },
  { key = "p",  mods = "LEADER",       action = act.ActivateTabRelative(-1) },

  -- Rename current tab
  {
    key = ",",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "Rename tab:",
      action = wezterm.action_callback(function(window, _, line)
        -- line is nil if the user hit Escape; empty string clears the title.
        if line ~= nil then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  -- Quick distro / launcher menu
  { key = "d", mods = "LEADER",      action = act.ShowLauncherArgs({ flags = "FUZZY|DOMAINS" }) },

  -- Copy mode + clipboard
  { key = "[", mods = "LEADER",      action = act.ActivateCopyMode },
  { key = "v", mods = "LEADER",      action = act.PasteFrom("Clipboard") },

  -- Send a literal CTRL+` to the terminal
  { key = "`", mods = "LEADER|CTRL", action = act.SendKey({ key = "`", mods = "CTRL" }) },

  -- Font size
  { key = "=", mods = "CTRL",        action = act.IncreaseFontSize },
  { key = "-", mods = "CTRL",        action = act.DecreaseFontSize },
  { key = "0", mods = "CTRL",        action = act.ResetFontSize },
}

-- Jump to tab N with LEADER + number
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

--------------------------------------------------------------------------------
-- Startup: open one WezTerm window per restored tmux session
--------------------------------------------------------------------------------
-- tmux-resurrect/continuum restores all sessions when the server starts, but
-- WezTerm doesn't remember which window showed which session. On GUI launch we
-- restore + list the sessions (via ~/.local/bin/tmux-boot) and open a window
-- attached to each. Falls back to a normal window if there are none.
wezterm.on("gui-startup", function()
  local mux = wezterm.mux
  local sessions = {}
  local ok, stdout = pcall(function()
    local success, out = wezterm.run_child_process({
      "wsl.exe", "-d", "Ubuntu", "--", "bash", "-lc", "$HOME/.local/bin/tmux-boot",
    })
    return success and out or ""
  end)
  if ok and stdout then
    for line in stdout:gmatch("[^\r\n]+") do
      local name = line:gsub("%s+$", "")
      if #name > 0 then
        table.insert(sessions, name)
      end
    end
  end

  if #sessions == 0 then
    mux.spawn_window({}) -- no sessions: just a normal WSL window
  else
    for _, name in ipairs(sessions) do
      mux.spawn_window({ args = { "tmux", "attach", "-t", name } })
    end
  end
end)

return config
