local ok, elixir = pcall(require, "elixir")
if not ok then return end

elixir.setup({
  elixirls = {
    cmd = "/home/juan/code/elixir/elixir-ls/language_server.sh"
  },
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<leader>ef", ":ElixirFromPipe<CR>", { buffer = true, noremap = true })
    vim.keymap.set("n", "<leader>et", ":ElixirToPipe<CR>", { buffer = true, noremap = true })
    vim.keymap.set("n", "<leader>em", ":ElixirExpandMacro<CR>", { buffer = true, noremap = true })
  end
})
