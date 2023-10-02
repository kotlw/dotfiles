local M = {}

M.gap = 10
M.scaleStep = 10

local function scaleRect(rect, units)
  return hs.geometry.rect(
    rect.x - units,
    rect.y - units,
    rect.w + units * 2,
    rect.h + units * 2
  )
end

local function boundaryFrame()
  return scaleRect(hs.screen.mainScreen():frame(), -M.gap)
end

local function scale(step)
  local window = hs.window.focusedWindow()
  local boundary = boundaryFrame()
  local windowFrame = scaleRect(window:frame(), step)
  window:setFrame(windowFrame:intersect(boundary))
end

function M.smaller() scale(-M.scaleStep) end

function M.larger() scale(M.scaleStep) end

function M.toggleFullscreen()
  local window = hs.window.focusedWindow()
  window:setFullScreen(not window:isFullScreen())
end

function M.maximize()
  local window = hs.window.focusedWindow()
  local frame = boundaryFrame()
  window:setFrame(frame)
end

function M.leftHalf()
  local window = hs.window.focusedWindow()
  local frame = boundaryFrame()
  frame.w = (frame.w / 2) - (M.gap * 1.5)
  window:setFrame(frame)
end

function M.rightHalf()
  local window = hs.window.focusedWindow()
  local frame = boundaryFrame()
  frame.x = (frame.w / 2) + M.gap / 2
  frame.w = (frame.w / 2) + M.gap / 2
  window:setFrame(frame)
end

return M
