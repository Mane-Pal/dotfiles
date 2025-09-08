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

-- CodeCompanion keymaps
map(
  { "n", "v" },
  "<leader>ac",
  ":CodeCompanionActions<CR>",
  { noremap = true, silent = true, desc = "CodeCompanion Actions" }
)
map(
  { "n", "v" },
  "<leader>aa",
  ":CodeCompanionChat Toggle<CR>",
  { noremap = true, silent = true, desc = "Toggle CodeCompanion Chat" }
)
map(
  "v",
  "<leader>aC",
  ":CodeCompanionChat Add<CR>",
  { noremap = true, silent = true, desc = "Add to CodeCompanion Chat" }
)

-- Linear CLI which-key group
local wk = require("which-key")
wk.add({
  { "<leader>l", group = "Linear" },
  { "<leader>lS", desc = "Setup integration" },
  { "<leader>la", desc = "Test authentication" },
  { "<leader>ls", desc = "Sync issues" },
  { "<leader>lb", desc = "Browse local issues" },
  { "<leader>lf", desc = "Search all issues" },
  { "<leader>lg", desc = "Create git branch" },
  { "<leader>lc", desc = "Config (init/edit/show)" },
})
