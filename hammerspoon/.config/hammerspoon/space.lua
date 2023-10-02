local M = {}

M.icons = {}

local menuBar = hs.menubar.new()

local function sortedWindows()
  local allWindows = hs.window.allWindows()
  table.sort(allWindows, function(a, b) return a:id() < b:id() end)
  return allWindows
end

local function refreshMenuBar()
  local focusedId = hs.window.focusedWindow():id()
  local title = hs.styledtext.new("")

  for _, window in pairs(sortedWindows()) do
    local currentId = window:id()
    local icon = M.icons[window:application():name()] or M.icons.Unknown
    local color = { red = 0, green = 0, blue = 0, alpha = currentId == focusedId and 1 or 0.4 }
    title = title .. hs.styledtext.new(icon, { font = { name = "FiraMono Nerd Font", size = 14 }, color = color })
  end

  menuBar:setTitle(title)
end

local function getSpaceID(position)
  local spaces = hs.spaces.allSpaces()
  _, IDs = pairs(spaces)(spaces)
  return IDs[position]
end

local function moveToSpace(position)
  local window = hs.window.focusedWindow()
  hs.spaces.moveWindowToSpace(window, getSpaceID(position))
  window:focus()
end

function M.showMenuBar() hs.spaces.watcher.new(refreshMenuBar):start() end

function M.moveToSpace1() moveToSpace(1) end

function M.moveToSpace2() moveToSpace(2) end

function M.moveToSpace3() moveToSpace(3) end

function M.moveToSpace4() moveToSpace(4) end

function M.moveToSpace5() moveToSpace(5) end

function M.createSpace()
  local screen = hs.screen.mainScreen()
  hs.spaces.addSpaceToScreen(screen, false)
end

function M.destroyLastSpace()
  local spaces = hs.spaces.allSpaces()
  _, IDs = pairs(spaces)(spaces)
  hs.spaces.removeSpace(IDs[#IDs], false)
end

function M.printWindows()
  local allWindows = sortedWindows()
  hs.alert.show(M.icons)
  for i, w in pairs(allWindows) do
    hs.alert.show(i)
    hs.alert.show(w:application():name())
  end
end

-- function M.focusPrev()
--   local focusedWindow = hs.window.focusedWindow()
--   local allWindows = sortedWindows()
--   local prev = allWindows[#allWindows]
--   for i, w in pairs(allWindows) do
--     if w:id() == focusedWindow:id() and i ~= 1 then
--       prev = allWindows[i - 1]
--       break
--     end
--   end
--   prev:focus()
--   refreshMenuBar()
-- end
--
-- function M.focusNext()
--   local focusedWindow = hs.window.focusedWindow()
--   local allWindows = sortedWindows()
--   local next = allWindows[1]
--   for i, w in pairs(allWindows) do
--     if w:id() == focusedWindow:id() and i ~= #allWindows then
--       next = allWindows[i + 1]
--       break
--     end
--   end
--   next:focus()
--   refreshMenuBar()
-- end

return M
