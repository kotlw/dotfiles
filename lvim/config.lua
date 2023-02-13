-- Reference: https://github.com/LunarVim/LunarVim/blob/release-1.2/neovim-0.8/utils/installer/config.example.lua

-- Vars
local cmp      = require("cmp")
local Terminal = require('toggleterm.terminal').Terminal


-- General
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "lunar"


-- Keymappings
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<leader>oo"] = "o<esc>k"
lvim.keys.normal_mode["<leader>O"] = "O<esc>j"
lvim.keys.visual_mode['a"'] = '2i"'
lvim.keys.visual_mode["a'"] = "2i'"
lvim.keys.visual_mode["a`"] = "2i`"
lvim.keys.normal_mode["<c-h>"] = ":lua require('Navigator').left()<cr>"
lvim.keys.normal_mode["<c-j>"] = ":lua require('Navigator').down()<cr>"
lvim.keys.normal_mode["<c-k>"] = ":lua require('Navigator').up()<cr>"
lvim.keys.normal_mode["<c-l>"] = ":lua require('Navigator').right()<cr>"
lvim.builtin.cmp.mapping["<C-n>"] = cmp.mapping.complete()
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}
lvim.builtin.which_key.mappings["g"]["g"] = { ":lua (function()LAZYGIT_TERMINAL:toggle()end)()<cr>", "Lazygit" }


-- Theme
lvim.transparent_window = true


-- Plugins
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "go",
  "java",
  "yaml",
}
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.terminal.size = 5
lvim.builtin.terminal.direction = "horizontal"
LAZYGIT_TERMINAL = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  float_opts = {
    border = "curved",
  },
})


-- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.surround").setup()
      require("mini.trailspace").setup()
    end,
    branch = "stable",
  },
  {
    "numToStr/Navigator.nvim",
    config = function() require("Navigator").setup() end,
  },
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = true,
      })
      vim.cmd.colorscheme "catppuccin"
    end
  },
  {
    "simrat39/rust-tools.nvim",
    config = function() require("rust-tools").setup() end
  }
}
