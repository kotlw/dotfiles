vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup({
  spec = {
    { "nvim-lua/plenary.nvim" },
    { "neovim/nvim-lspconfig" },
    { "nvimtools/none-ls.nvim" },
    { "nvim-telescope/telescope.nvim", tag = "0.1.8" },
    { "catppuccin/nvim",               name = "catppuccin", opts = { flavour = "macchiato", } },
    { "ThePrimeagen/harpoon",          branch = "harpoon2", config = true },
    { "echasnovski/mini.completion",   version = false,     config = true },
    { "echasnovski/mini.diff",         version = false,     config = true },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup {
          highlight = { enable = true },
          indent = { enable = true }
        }
      end
    },
  },
})

vim.opt.path:append("**")
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

local harpoon = require('harpoon')
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.mypy,
  },
})

local lspconfig = require("lspconfig")
lspconfig.ruff.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.jedi_language_server.setup {}
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
}

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
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
    vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
  end,
})

-- workaround for rust_analyzer: -32802: server cancelled the request
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
      return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end
