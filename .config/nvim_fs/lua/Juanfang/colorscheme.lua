-- local status_ok, _ = pcall(require, "rose-pine")
--
--
--
-- if not status_ok then return end
--
-- local rose_pine = require "rose-pine"
--
-- rose_pine.setup {
--   variant = "auto",
--   highlight_groups = {
--     -- Keyword = { fg = "iris" },
--     -- ["@keyword.operator"] = { fg = "pine" },
--     -- conditional = { fg = "foam" },
--   },
-- }
-- local colorscheme = "rose-pine"
-- require("nightfox").setup({
--   options = {
--     dim_inactive = true,
--   }
-- })
-- local colorscheme = "carbonfox"
-- local ok, onedark = pcall(require, "onedark")
-- if not ok then return end
-- onedark.setup({
--   style = "warmer",
--   ending_tildes = true,
--   toggle_style_key = "<leader>ts",
-- })
-- onedark.load()
-- local colorscheme = "onedark"
-- local starry = require "starry"
-- starry.setup()
--
-- local colorscheme = "dracula_blood"
--
-- vim.g.starry_daylight_switch = true
-- local colorscheme = "onedark"
-- local colors = require("onedarkpro.helpers").get_colors(colorscheme)
--
-- require("onedarkpro").setup({
--   -- colors = {
--   -- },
--   options = {
--     cursorline = true,
--   },
--   highlights = {
--     ["@variable.elixir"] = colors.fg,
--     ["@variable.javascript"] = colors.fg,
--     ["@tag.attribute.heex"] = colors.fg,
--   }
-- })
local ok, catppuccin = pcall(require, "catppuccin")
if not ok then return end

catppuccin.setup({
  flavor = "latte",
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  integrations = {
    -- lualine = true,
    barbar = true,
    which_key = true,
  }
})
local colorscheme = "catppuccin-latte"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
