local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  completion = { autocomplete = false },
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  window = {
    completion = { border = "rounded" },
    documentation = { border = "rounded" },
  },

  mapping = {
    ["<c-d>"] = cmp.mapping.scroll_docs(-5),
    ["<c-f>"] = cmp.mapping.scroll_docs(5),
    ["<c-e>"] = cmp.mapping.close(),
    ["<cr>"] = function(fallback)
      if cmp.visible() then
        return cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        } (fallback)
      else
        return fallback()
      end
    end,

    ["<c-n>"] = cmp.mapping(function(fallback)
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

    ["<c-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  sources = {
    { name = "path", priority_weight = 110 },
    { name = "nvim_lsp", max_item_count = 20, priority_weight = 100 },
    { name = "buffer", max_item_count = 5, priority_weight = 70 },
    { name = "nvim_lua" },
    { name = "luasnip" },
  },
})
