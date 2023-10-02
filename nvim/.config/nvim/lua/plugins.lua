return {
  { "jghauser/follow-md-links.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "simrat39/rust-tools.nvim" },
  { "iamcco/markdown-preview.nvim" },
  {
    "folke/which-key.nvim",
    config = function() require("which-key").setup() end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function() require("config/nvim-dap") end,
  },
  { "rcarriga/nvim-dap-ui" },
  {
    "neovim/nvim-lspconfig",
    config = function() require("config/nvim-lspconfig") end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function() require("config/null-ls") end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function() require("config/lualine") end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("gitsigns").setup() end,
  },
  {
    "akinsho/bufferline.nvim",
    config = function() require("config/bufferline") end,
  },
  {
    "numToStr/Navigator.nvim",
    config = function() require("Navigator").setup() end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function() require("config/nvim-treesitter") end,
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    config = function() require("mini.surround").setup() end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function() require("Comment").setup() end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function() require("config/catppuccin") end,
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function() require("config/telescope") end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function() require("config/nvim-cmp") end,
  },
}
