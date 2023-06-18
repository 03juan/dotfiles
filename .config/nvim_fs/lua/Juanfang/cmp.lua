local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end
require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local lspkind = require("lspkind")

lspkind.init({
  mode = "text_symbol",
  preset = "codicons",
  symbol_map = {
    Copilot = "",
  },
})

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- removes default `<C-y>` mapping
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected:
    -- `select` first item when select is `true`
    -- only configm explicitly selected item when `false`
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      maxwidth = 50,
      ellipsis_char = "...",
      -- before = function(entry, vim_item)
      --     print(vim.inspect(vim_item))
      --   -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      --
      --   vim_item.menu = ({
      --     nvim_lsp = "[LSP]",
      --     nvim_lua = "[LUA]",
      --     luasnip = "[Snip]",
      --     buffer = "[Buf]",
      --     path = "[Path]",
      --   })[entry.source.name]
      --
      --   return vim_item
      -- end,
    }),
  },
  sources = {
    { name = "copilot", group_index = 2 },
    { name = "nvim_lsp", group_index = 2 },
    { name = "nvim_lua", group_index = 2 },
    { name = "luasnip", group_index = 2 },
    { name = "buffer", group_index = 2 },
    { name = "path", group_index = 2 },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
})

cmp.event:on("menu_opened", function()
  vim.b.copilot_suggestion_hidden = true
end)
cmp.event:on("menu_closed", function()
  vim.b.copilot_suggestion_hidden = false
end)
