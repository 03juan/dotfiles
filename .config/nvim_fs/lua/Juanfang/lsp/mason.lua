local servers = {
  "lua_ls",
  "jsonls",
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 6,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_isntallation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local handlers = require("Juanfang.lsp.handlers")
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
}

for _, server in pairs(servers) do
  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "Juanfang.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end

lspconfig.elixirls.setup({
  cmd = { "/home/juan/code/elixir/elixir-ls/language_server.sh" },
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.eslint.setup({
  cmd = { "vscode-eslint-language-server", "--stdio" },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  capabilities = capabilities,
})

lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "tailwindcss-language-server" },
  filetypes = {
    "eelixir",
    "elixir",
    "html",
    "html-eex",
    "heex",
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "javascript",
  },
  init_options = {
    userLanguages = {
      elixir = "html-eex",
      eelixir = "html-eex",
      heex = "html-eex",
    },
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          'class[:]\\s*"([^"]*)"',
        },
      },
    },
  },
  root_dir = function(fname)
    local util = require("lspconfig.util")
    local tw = require("lspconfig.server_configurations.tailwindcss")

    local in_asset = util.root_pattern("assets/tailwind.config.js")(fname)
    if in_asset then
      return in_asset
    else
      return tw.default_config.root_dir(fname)
    end
  end,
})

lspconfig.cssls.setup(opts)
lspconfig.html.setup(opts)

lspconfig.tsserver.setup({
  on_attach = on_attach,
  filetypes = { "javascript", "javascript.jsx", "typescript", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim",
  },
  cmd = { "typescript-language-server", "--stdio" },
})

