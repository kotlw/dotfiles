local _M = {}

_M.gap = 10
_M.resizeUnit = 10
hs.window.animationDuration = _M.duration

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
  return scaleRect(s:frame(), -_M.gap)
end

local function scale(units)
  local w = hs.window.focusedWindow()
  local wf = scaleRect(w:frame(), units)
  w:setFrame(wf:intersect(screenFrame()))
end

local function stick(side)
  local w = hs.window.focusedWindow()
  local sf = screenFrame()

  if side == "left" then
    sf.w = (sf.w / 2) - (_M.gap * 1.5)
  elseif side == "right" then
    sf.x = (sf.w / 2) + _M.gap / 2
    sf.w = (sf.w / 2) + _M.gap / 2
  end

  w:setFrame(sf)
end

function _M.maximize()
  stick("full")
end

function _M.leftHalf()
  stick("left")
end

function _M.rightHalf()
  stick("right")
end

function _M.incSize()
  scale(_M.resizeUnit)
end

function _M.decSize()
  scale(-_M.resizeUnit)
end

return _M
