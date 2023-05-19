local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = "",
  sync_install = false,
  ignore_install = { "" },
  auto_install = true,
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml" } },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  autotag = {
    enable = true,
    filetypes = { "html", "javascript", "jsx", "solid", "heex", "elixir" },
  },
  autopairs = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
})

local context_staus_ok, context = pcall(require, "treesitter-context")
if not context_staus_ok then
  return
end

context.setup()

vim.keymap.set("n", "[c", function()
  context.go_to_context()
end, { silent = true })
