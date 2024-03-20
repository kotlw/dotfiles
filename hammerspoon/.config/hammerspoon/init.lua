local function bind(mods, binds)
  for key, fn in pairs(binds) do
    if fn then
      hs.hotkey.bind(mods, tostring(key), fn, nil, fn)
    end
  end
end

local function launchOrFocusByBundleID(bundleID)
  return function() hs.application.launchOrFocusByBundleID(bundleID) end
end

local function showAppBundleID()
  hs.alert.show(hs.window.focusedWindow():application():bundleID())
end

local function toggleFullscreen()
  local window = hs.window.focusedWindow()
  window:setFullScreen(not window:isFullScreen())
end

-- Hammerspoon
bind({ "alt", "ctrl", "cmd" }, {
  ["R"] = hs.reload,
  ["C"] = hs.toggleConsole,
  ["B"] = showAppBundleID,
})

-- Application shortcuts
bind({ "ctrl", "alt" }, {
  ["Z"]      = launchOrFocusByBundleID("us.zoom.xos"),
  ["return"] = launchOrFocusByBundleID("org.alacritty"),
  ["K"]      = launchOrFocusByBundleID("com.skype.skype"),
  ["A"]      = launchOrFocusByBundleID("net.ankiweb.dtop"),
  ["C"]      = launchOrFocusByBundleID("com.cockos.reaper"),
  ["B"]      = launchOrFocusByBundleID("com.brave.Browser"),
  ["H"]      = launchOrFocusByBundleID("com.google.Chrome"),
  ["T"]      = launchOrFocusByBundleID("com.microsoft.teams2"),
  ["O"]      = launchOrFocusByBundleID("com.microsoft.Outlook"),
  ["W"]      = launchOrFocusByBundleID("com.bitwarden.desktop"),
  ["M"]      = launchOrFocusByBundleID("com.tdesktop.Telegram"),
  ["R"]      = launchOrFocusByBundleID("com.microsoft.rdc.macos"),
  ["J"]      = launchOrFocusByBundleID("net.cozic.joplin-desktop"),
  ["G"]      = launchOrFocusByBundleID("com.arobas-music.guitarpro7"),
})

-- Window management
bind({ "alt", "shift" }, {
  ["\\"] = toggleFullscreen,
})
