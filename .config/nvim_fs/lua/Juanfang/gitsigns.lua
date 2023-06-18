local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then return end

gitsigns.setup({
  worktrees = {
    {
      dotdir = vim.env.HOME .. "/.dotfiles",
      home = vim.env.HOME,
    },
  },
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = false,
  numhl = true,
  linehl = false,
  word_diff = true,
  watch_gitdir = {
    itnerval = 1000,
    follow_files = true,
  },
  attach_to_untracked = false,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_post = "right-align",
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = true,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end

      vim.schedule(function() gs.next_hunk() end)

      return "<Ignore>"
    end, { expr = true, desc = "git next hunk" })

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end

      vim.schedule(function() gs.prev_hunk() end)

      return "<Ignore>"
    end, { expr = true, desc = "git prev hunk" })

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "git stage buffer" })
    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "git undo stage hunk" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "git reset buffer" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "git preview hunk" })
    map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "git full blame line" })
    map("n", "<leader>hd", gs.diffthis, { desc = "git diff this" })
    map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "git diff this ~" })

    map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "git toggle current line blame" })
    map("n", "<leader>td", gs.toggle_deleted, { desc = "git toggle deleted" })

    local v_args = { vim.fn.line("."), vim.fn.line("v") }
    map("v", "<leader>hs", function() gs.stage_hunk(v_args) end, { desc = "git stage hunk" })
    map("v", "<leader>hr", function() gs.reset_hunk(v_args) end, { desc = "git reset hunk" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})
