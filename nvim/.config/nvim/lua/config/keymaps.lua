-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Inlay hints navigation
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle Inlay Hints" })

-- If you want to navigate through inlay hints
-- Note: These are example bindings, adjust as needed
map("i", "<C-l>", function()
  require("lsp.utils").accept_inlay_hint()
end, { desc = "Accept Inlay Hint" })

-- Set Go build tags via GOFLAGS
map("n", "<leader>ct", function()
  vim.ui.input({ prompt = "Enter Go tags: " }, function(tags)
    if tags then
      -- Set GOFLAGS environment variable
      vim.env.GOFLAGS = "-tags=" .. tags
      -- Restart gopls to pick up the new environment
      vim.cmd("LspRestart")
      vim.notify("GOFLAGS set to: " .. vim.env.GOFLAGS, vim.log.levels.INFO)
    end
  end)
end, { desc = "Set Go Build Tags" })

-- Clear quickfix list
map("n", "<leader>xd", function()
  vim.fn.setqflist({})
  vim.notify("Quickfix list cleared", vim.log.levels.INFO)
end, { desc = "Clear Quickfix List" })

-- Remap Lazy from <leader>l to <leader>L (uppercase)
-- Delete the default <leader>l binding and remap to <leader>L
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    -- Delete old bindings
    pcall(vim.keymap.del, "n", "<leader>l")
    pcall(vim.keymap.del, "n", "<leader>L")

    -- Remap Lazy to uppercase L
    vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })
  end,
})

-- snacks-linear which-key group (using lowercase l)
local wk = require("which-key")
wk.add({
  { "<leader>l", group = "Linear" },
  { "<leader>ll", desc = "List all issues (searchable)" },
  { "<leader>li", desc = "Issues (todo/in-progress)" },
  { "<leader>lm", desc = "My assigned issues" },
  { "<leader>lt", desc = "Browse teams" },
  { "<leader>ln", desc = "Create new issue" },
  { "<leader>lc", desc = "Clear cache" },
})
