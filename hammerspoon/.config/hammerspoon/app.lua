local M = {}

function M.launchOrFocus(name)
  return function() hs.application.launchOrFocus(name) end
end

function M.launchOrFocusByBundleID(bundleID)
  return function() hs.application.launchOrFocusByBundleID(bundleID) end
end

function M.showAppName()
  hs.alert.show(hs.window.focusedWindow():application():name())
end

function M.showAppBundleID()
  hs.alert.show(hs.window.focusedWindow():application():bundleID())
end

return M
