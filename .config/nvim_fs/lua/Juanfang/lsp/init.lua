local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then return end

require("Juanfang.lsp.mason")
require("Juanfang.lsp.handlers").setup()
require("Juanfang.lsp.null-ls")

vim.diagnostic.config({
  virtual_text = {
    source = "always",
  },
  float = {
    source = "always",
  },
})
