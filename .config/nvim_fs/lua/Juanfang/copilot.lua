local ok, copilot = pcall(require, "copilot")
if not ok then
  print("error loading 'copilot'")
  return
end

local copilot_cmp_ok, copilot_cmp = pcall(require, "copilot_cmp")
if not copilot_cmp_ok then
  print("error loading 'copilot_cmp")
  return
end

copilot_cmp.setup()
