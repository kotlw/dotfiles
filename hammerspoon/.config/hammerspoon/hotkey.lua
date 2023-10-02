local M = {}

function M.bind(mods, binds)
   for key, fn in pairs(binds) do
    if fn then
      hs.hotkey.bind(mods, tostring(key), fn, nil, fn)
    end
  end
end

return M
