local status_ok, which = pcall(require, 'which-key')
if not status_ok then
  return
end

which.setup {}
