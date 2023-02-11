local M = {}

M.gap = 10
hs.window.animationDuration = M.duration

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
  hs.spaces.addSpaceToScreen(s)
end

return M
