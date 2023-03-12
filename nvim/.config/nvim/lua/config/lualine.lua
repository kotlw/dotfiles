require("lualine").setup({
  options = {
    component_separators = "",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_b = {},
    lualine_c = {"branch", "diff", "diagnostics"},
    lualine_x = { "require'lsp-status'.status()", "location", "progress" },
    lualine_y = {},
    lualine_z = {},
  }
})
