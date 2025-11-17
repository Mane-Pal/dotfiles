-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.diagnostic.disable()
  end,
})

-- Load GameScanner keymaps when opening Python test files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function()
    local cwd = vim.fn.getcwd()
    if cwd:match("GameScanner") then
      require("config.gamescanner").setup()
    end
  end,
})

-- Create user commands for GameScanner
vim.api.nvim_create_user_command("GSTest", function()
  require("config.gamescanner").run_test()
end, { desc = "Run GameScanner test in container" })

vim.api.nvim_create_user_command("GSTestOutput", function()
  require("config.gamescanner").run_test_with_output()
end, { desc = "Run GameScanner test with output" })

-- Set 4-space indentation for bash scripts
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "bash", "zsh" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

-- Set 4-space indentation for YAML files in GameScanner repo
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "yml" },
  callback = function()
    local filepath = vim.fn.expand("%:p")
    if filepath:match("GameScanner") then
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
      vim.opt_local.expandtab = true
    end
  end,
})
