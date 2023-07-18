local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer. Close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use("wbthomason/packer.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins

  -- use "EdenEast/nightfox.nvim"
  -- use({ "rose-pine/neovim", as = "rose-pine" })
  -- use("navarasu/onedark.nvim")
  -- use "ray-x/starry.nvim"
  -- use("olimorris/onedarkpro.nvim")
  -- use("tomasiser/vim-code-dark")
  -- use("humbertocarmona/kanagawa-mod.nvim")
  -- use("no-clown-fiesta/no-clown-fiesta.nvim")
  -- use("AlexvZyl/nordic.nvim")
  -- use("water-sucks/darkrose.nvim")
  -- use("girishji/declutter.nvim")
  use("ribru17/bamboo.nvim")
  use("Almo7aya/neogruvbox.nvim")
  use({ "catppuccin/nvim", as = "catppuccin" })

  -- cmp plugins
  use("hrsh7th/nvim-cmp")         -- The completion plugin
  use("hrsh7th/cmp-buffer")       -- buffer completions
  use("hrsh7th/cmp-path")         -- path completions
  use("hrsh7th/cmp-cmdline")      -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-nvim-lsp-signature-help")
  use("onsails/lspkind.nvim")

  -- snippets
  use("L3MON4D3/LuaSnip")             --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- LSP
  use("neovim/nvim-lspconfig")             -- enable LSP
  use("williamboman/mason.nvim")           -- simple to use language server installer
  use("williamboman/mason-lspconfig.nvim") -- simple to use language server installer
  use("jose-elias-alvarez/null-ls.nvim")   -- LSP diagnostics and code actions
  use("mfussenegger/nvim-jdtls")           -- Java LSP

  use({ "prettier/vim-prettier", run = "yarn install --frozen-lockfile --production" })

  use("chrisbra/Colorizer")

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
  })

  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      { "nvim-tree/nvim-web-devicons", opt = true },
      "MunifTanjim/nui.nvim",
    },
  })

  use("junegunn/fzf")
  use("junegunn/fzf.vim")

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-telescope/telescope-github.nvim",
    },
  })

  use("nvim-telescope/telescope-media-files.nvim")
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  })

  use("smartpde/telescope-recent-files")
  use("kdheepak/lazygit.nvim")

  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  use("p00f/nvim-ts-rainbow")
  use("nvim-treesitter/nvim-treesitter-context")
  use("windwp/nvim-ts-autotag")

  use("windwp/nvim-autopairs")

  use("numToStr/Comment.nvim")

  use("lewis6991/gitsigns.nvim")

  use("nvim-tree/nvim-web-devicons")
  use("romgrk/barbar.nvim")

  use("ahmedkhalf/project.nvim")

  use("folke/which-key.nvim")

  use({
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "LspAttach", "InsertEnter" },
    fix_pairs = true,
    config = function()
      require("copilot").setup({
        filetypes = {
          javascript = true,
          elixir = true,
        },
        suggestion = {
          enabled = false,
        },
        panel = {
          enabled = false,
        },
      })
    end,
  })

  use({
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  })

  -- use "lukas-reineke/indent-blankline.nvim"
  -- Automoatically set up configuration after cloning packer.nvim
  -- should be the last command after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
