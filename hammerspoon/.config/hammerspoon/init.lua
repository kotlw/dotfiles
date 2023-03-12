local wm = require("window-manager")

-- Aliases
local bind = hs.hotkey.bind
local bindr = function(mods, key, fn) bind(mods, key, fn, nil, fn) end
local focusedWindow = hs.window.focusedWindow
local launchOrFocus = hs.application.launchOrFocus


-- Hammerspoon
bind({ "cmd", "alt", "ctrl" }, "R", function() hs.reload() end)
bind({ "cmd", "alt", "ctrl" }, "T", function() hs.console.hswindow():focus() end)
bind({ "cmd", "alt", "ctrl" }, "N", function() hs.alert.show(hs.window.focusedWindow():application():name()) end)


-- Application shortcuts
bind("alt", "return", function() launchOrFocus("Alacritty") end)
bind("alt", "\\", function() launchOrFocus("Firefox") end)


-- Window management
bindr({ "ctrl", "alt" }, "=", function() wm.scale(10) end)
bindr({ "ctrl", "alt" }, "-", function() wm.scale(-10) end)
bind({ "ctrl", "alt" }, "return", function() wm.shift("full") end)
bind({ "ctrl", "alt" }, "left", function() wm.shift("left") end)
bind({ "ctrl", "alt" }, "right", function() wm.shift("right") end)
bind({ "ctrl", "alt" }, "\\", function() wm.toggleFullScreen() end)
bind({ "ctrl", "alt" }, "1", function() wm.moveToSpace(1) end)
bind({ "ctrl", "alt" }, "2", function() wm.moveToSpace(2) end)
bind({ "ctrl", "alt" }, "3", function() wm.moveToSpace(3) end)
bind({ "ctrl", "alt" }, "4", function() wm.moveToSpace(4) end)
bind({ "ctrl", "alt" }, "5", function() wm.moveToSpace(5) end)
bind({ "alt" }, "`", function() wm.createSpace() end)
bind({ "shift", "alt" }, "`", function() wm.destroyLastSpace() end)
bind({ "ctrl", "alt" }, "Q", function() wm.focusPrev() end)
bind({ "ctrl", "alt" }, "E", function() wm.focusNext() end)
