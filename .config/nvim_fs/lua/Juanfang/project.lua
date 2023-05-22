local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
  return
end

project.setup {
  detection_methods = { "pattern" },
  patterns = { ".git", "mix.exs", "package.json", "=nvim_fs" },
}
