local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "neovim/nvim-lspconfig" },
  { "nvimtools/none-ls.nvim" },
  { "L3MON4D3/LuaSnip" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.5" },
  { "lewis6991/gitsigns.nvim",       config = true },
  { "ThePrimeagen/harpoon",          branch = "harpoon2" },
  { "echasnovski/mini.surround",     config = true,      version = "*" },
  { "echasnovski/mini.comment",      config = true,      version = "*" },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":tsupdate",
    opts = {
      parser_install_dir = "~/.local/share/nvim/lazy/nvim-treesitter/parser/",
      ensure_installed = {
        "bash", "make", "go", "lua", "python", "markdown", "html",
        "css", "json", "yaml", "toml", "dockerfile", "rust", "org",
      },
    }
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
      transparent_background = true
    },
  },
})

vim.cmd.colorscheme("catppuccin")

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
vim.keymap.set("n", "<leader>pe", vim.cmd.Ex)        -- open Netrw
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")         -- move selection up and down
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")         -- move selection up and down
vim.keymap.set("n", "<leader>bn", ":bn<cr>")         -- next buffer
vim.keymap.set("n", "<leader>bp", ":bp<cr>")         -- previous buffer
vim.keymap.set("n", "<leader>h", vim.cmd.nohlsearch) -- clear highlight


local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<c-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<c-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<c-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<c-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<c-s>", function() harpoon:list():select(4) end)


local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>fg", function() telescope.live_grep({ hidden = true }) end)
vim.keymap.set("n", "<leader>ff", function() telescope.find_files({ hidden = true }) end)
vim.keymap.set("n", "<leader>fb", function() telescope.buffers({ hidden = true }) end)

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
  },
})

local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.gopls.setup({})
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT" },
      diagnostics = {
        globals = { "vim", "hs" }
      },
    },
  },
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ["<c-b>"]     = cmp.mapping.scroll_docs(-4),
    ["<c-f>"]     = cmp.mapping.scroll_docs(4),
    ["<c-space>"] = cmp.mapping.complete(),
    ["<c-e>"]     = cmp.mapping.abort(),
    ["<cr>"]      = cmp.mapping.confirm({ select = true }),
    ["<tab>"]     = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<s-tab>"]   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
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
