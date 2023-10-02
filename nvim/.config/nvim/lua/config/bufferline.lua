require("bufferline").setup({
  options = {
    numbers = "ordinal",
    diagnostics = "nvim_lsp",
    tab_size = 5,
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = ""
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " "
            or (e == "warning" and " " or " ")
        s = s .. " " .. sym .. n
        s = s:gsub("^%s*(.-)%s*$", "%1")
      end
      return s
    end
  },
})
