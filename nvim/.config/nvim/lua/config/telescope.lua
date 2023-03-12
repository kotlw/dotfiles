local fb_actions = require "telescope".extensions.file_browser.actions
require("telescope").setup({
  extensions = {
    file_browser = {
      mappings = {
        ["i"] = {
          ["<c-c>"] = fb_actions.create,
          ["<c-r>"] = fb_actions.rename,
          ["<c-d>"] = fb_actions.remove,
        },
      },
    },
  },
})
require("telescope").load_extension("file_browser")
