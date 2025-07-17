vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup({
  spec = {
    { "nvim-lua/plenary.nvim" },
    { "neovim/nvim-lspconfig" },
    { "nvim-telescope/telescope.nvim", tag = "0.1.8" },
    { "folke/tokyonight.nvim",         opts = { transparent = true } },
    { "ThePrimeagen/harpoon",          branch = "harpoon2",          config = true },
    { "echasnovski/mini.diff",         version = false,              config = true },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-nvim-lsp" },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function() require("nvim-treesitter.configs").setup { highlight = { enable = true } } end
    },
  },
})


vim.opt.path:append("**")
vim.cmd.colorscheme("tokyonight")

vim.o.number         = true
vim.o.tabstop        = 2
vim.o.swapfile       = false
vim.o.expandtab      = true
vim.o.clipboard      = "unnamedplus"
vim.o.shiftwidth     = 2
vim.o.relativenumber = true

vim.g.mapleader      = " "

vim.keymap.set("v", "<", "<gv")                      -- do not exit visual mode after shifting
vim.keymap.set("v", ">", ">gv")                      -- do not exit visual mode after shifting
vim.keymap.set("n", "n", "nzzzv")                    -- keep cursor in the middle of the screen
vim.keymap.set("n", "N", "Nzzzv")                    -- keep cursor in the middle of the screen
vim.keymap.set("n", "<c-d>", "<c-d>zz")              -- keep cursor in the middle of the screen
vim.keymap.set("n", "<c-u>", "<c-u>zz")              -- keep cursor in the middle of the screen
vim.keymap.set("x", "<leader>p", [["_dP]])           -- paste and keep in register
vim.keymap.set("n", "<leader>O", "O<esc>j")          -- insert new line abowe
vim.keymap.set("n", "<leader>oo", "o<esc>k")         -- insert new line below
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")         -- move selection up and down
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")         -- move selection up and down
vim.keymap.set("n", "<leader>pe", vim.cmd.Ex)        -- open explorer
vim.keymap.set("n", "<leader>h", vim.cmd.nohlsearch) -- clear highlight

vim.keymap.set("n", "<leader>bn", vim.cmd.bnext)
vim.keymap.set("n", "<leader>bp", vim.cmd.bprevious)
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete)

vim.keymap.set("n", "<leader>g", ":lua MiniDiff.toggle_overlay()<cr>")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = 'Telescope help tags' })

local harpoon = require('harpoon')
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
  end,
})

local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  })
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" }
  })
})
