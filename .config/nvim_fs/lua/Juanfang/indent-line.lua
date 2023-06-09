local status_ok, indent = pcall(require, "indent_blankline")
if not status_ok then
  return
end

vim.cmd [[ let g:indentLine_setColors = 0 ]]

indent.setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = false,
}
