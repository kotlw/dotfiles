local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

require("lualine").setup({
  options = {
    component_separators = "",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_b = {},
    lualine_c = { "branch", "diff", "diagnostics" },
    lualine_x = { { "macro-recording", fmt = show_macro_recording }, "location", "progress" },
    lualine_y = {},
    lualine_z = {},
  }
})
