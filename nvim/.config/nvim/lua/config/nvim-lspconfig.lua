local m = vim.keymap.set
local lsp = require("lspconfig")
local rt = require("rust-tools")

-- UI Customization
local cfg = { border = "rounded" }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, cfg)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, cfg)
vim.diagnostic.config({ float = cfg })

-- Mappings
local opts = { noremap = true, silent = true }
m("n", "<leader>e", vim.diagnostic.open_float, opts)
m("n", "[d", vim.diagnostic.goto_prev, opts)
m("n", "]d", vim.diagnostic.goto_next, opts)
m("n", "<leader>q", vim.diagnostic.setloclist, opts)

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  m("n", "gD", vim.lsp.buf.declaration, bufopts)
  m("n", "gd", vim.lsp.buf.definition, bufopts)
  m("n", "K", vim.lsp.buf.hover, bufopts)
  m("n", "gi", vim.lsp.buf.implementation, bufopts)
  m("n", "gh", vim.lsp.buf.signature_help, bufopts)
  m("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  m("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  m("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
  m("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
  m("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  m("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  m("n", "gr", vim.lsp.buf.references, bufopts)
  m("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Servers
lsp.pyright.setup({
  on_attach = on_attach,
})

lsp.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "hs" },
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach,
})

lsp.terraformls.setup {
  on_attach = on_attach,
}

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      on_attach(_, bufnr)
      m("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
    end,
  },
})

lsp.gopls.setup{
  on_attach = on_attach,
}

lsp.tsserver.setup({
  on_attach = on_attach,
})


local null_ls = require("null-ls")
null_ls.setup({
  on_attach = on_attach,
  sources = {
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.black.with({
      extra_args = { "--line-length", "80" }
    }),
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "html", "json", "yaml", "markdown" },
    })
  },
  root_dir = require("null-ls.utils").root_pattern(
    ".git"
  ),
})
