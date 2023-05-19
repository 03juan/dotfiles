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
  max_concurrent_installers = 4,
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
local opts = {
  on_attach    = handlers.on_attach,
  capabilities = handlers.capabilities,
}

for _, server in pairs(servers) do
  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "Juanfang.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end
