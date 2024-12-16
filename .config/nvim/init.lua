vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup({
  spec = {
    { "nvim-lua/plenary.nvim" },
    { "neovim/nvim-lspconfig" },
    { "nvimtools/none-ls.nvim" },
    { 'echasnovski/mini.completion', version = false, config = true },
    { 'echasnovski/mini.diff',       version = false, config = true },
  },
})

vim.opt.path:append("**")
vim.cmd.colorscheme("slate")

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
vim.keymap.set("n", "<leader>h", vim.cmd.nohlsearch) -- clear highlight

vim.keymap.set("n", "<leader>g", ":lua MiniDiff.toggle_overlay()<cr>")


local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.pylint.with({
      extra_args = { "--disable=C0111", "--max-line-length=120" }
    }),
    null_ls.builtins.formatting.isort.with({
      extra_args = { "--profile", "black", "--line-length", "120" }
    }),
    null_ls.builtins.formatting.black.with({
      extra_args = { "-l", "120" }
    }),
  },
})

local lspconfig = require("lspconfig")
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
