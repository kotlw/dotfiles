local M = {}

M.gap = 10
M.icons = {
  Alacritty = " ",
  Hammerspoon = "󰣪 ",
  Firefox = "󰈹 ",
  Telegram = " ",
  Obsidian = "󰮊 ",
  Calendar = " ",
  Books = " ",
  Preview = " ",
  Finder = "󰀶 ",
  Unknown = "󰘔 ",
}

local menuBar = hs.menubar.new()

local function refreshMenuBar()
  local focusedApp = hs.window.focusedWindow():application():name()
  local ww = hs.window.allWindows()
  local title = hs.styledtext.new("")

  for _, w in pairs(ww) do
    local currentApp = w:application():name()
    local icon = M.icons[currentApp] or M.icons.Unknown
    local color = { red = 1, green = 1, blue = 1, alpha = currentApp == focusedApp and 1 or 0.4 }
    title = title .. hs.styledtext.new(icon, { font = "FuraMono Nerd Font", color = color })
  end

  menuBar:setTitle(title)
end

hs.spaces.watcher.new(refreshMenuBar):start()

local function scaleRect(frame, units)
  return hs.geometry.rect(
    frame.x - units,
    frame.y - units,
    frame.w + units * 2,
    frame.h + units * 2
  )
end

local function screenFrame()
  local s = hs.screen.mainScreen()
  return scaleRect(s:frame(), -M.gap)
end

local function getSpaceID(position)
  local spaces = hs.spaces.allSpaces()
  _, IDs = pairs(spaces)(spaces)
  return IDs[position]
end

function M.scale(units)
  local w = hs.window.focusedWindow()
  local wf = scaleRect(w:frame(), units)
  w:setFrame(wf:intersect(screenFrame()))
end

function M.shift(place)
  local w = hs.window.focusedWindow()
  local sf = screenFrame()

  if place == "left" then
    sf.w = (sf.w / 2) - (M.gap * 1.5)
  elseif place == "right" then
    sf.x = (sf.w / 2) + M.gap / 2
    sf.w = (sf.w / 2) + M.gap / 2
  end

  w:setFrame(sf)
end

function M.toggleFullScreen()
  local w = hs.window.focusedWindow()
  w:setFullScreen(not w:isFullScreen())
end

function M.moveToSpace(position)
  local w = hs.window.focusedWindow()
  hs.spaces.moveWindowToSpace(w, getSpaceID(position))
  w:focus()
end

function M.createSpace()
  local s = hs.screen.mainScreen()
  hs.spaces.addSpaceToScreen(s, false)
end

function M.destroyLastSpace()
  local spaces = hs.spaces.allSpaces()
  _, IDs = pairs(spaces)(spaces)
  hs.spaces.removeSpace(IDs[#IDs], false)
end

function M.focusPrev()
  local focused = hs.window.focusedWindow()
  local ww = hs.window.allWindows()
  local prev = ww[#ww]
  for i, w in pairs(ww) do
    if w:id() == focused:id() and i ~= 1 then
      prev = ww[i - 1]
      break
    end
  end
  prev:focus()
  refreshMenuBar()
end

function M.focusNext()
  local focused = hs.window.focusedWindow()
  local ww = hs.window.allWindows()
  local next = ww[1]
  for i, w in pairs(ww) do
    if w:id() == focused:id() and i ~= #ww then
      next = ww[i + 1]
      break
    end
  end
  next:focus()
  refreshMenuBar()
end

return M
