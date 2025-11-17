-- GameScanner keymaps - loaded directly in config
-- This should be sourced from init.lua or autocmds.lua

local M = {}

-- Helper to check if in GameScanner repo
local function is_gamescanner_repo()
  local cwd = vim.fn.getcwd()
  return cwd:match("GameScanner") ~= nil
end

-- Run test in container
function M.run_test()
  if not is_gamescanner_repo() then
    vim.notify("Not in GameScanner repository", vim.log.levels.WARN)
    return
  end

  local current_file = vim.fn.expand("%:p")
  local filename = vim.fn.expand("%:t")

  -- Check if it's a test file
  if not (filename:match("^test_") or current_file:match("/tests/")) then
    vim.notify("Not a test file: " .. filename, vim.log.levels.WARN)
    return
  end

  -- Run test in a terminal split
  local cmd = string.format("./tools/execute_test.py %s", current_file)
  vim.cmd("split | terminal " .. cmd)
  vim.cmd("startinsert")
end

-- Run test with output
function M.run_test_with_output()
  if not is_gamescanner_repo() then
    vim.notify("Not in GameScanner repository", vim.log.levels.WARN)
    return
  end

  local current_file = vim.fn.expand("%:p")
  local filename = vim.fn.expand("%:t")

  -- Check if it's a test file
  if not (filename:match("^test_") or current_file:match("/tests/")) then
    vim.notify("Not a test file: " .. filename, vim.log.levels.WARN)
    return
  end

  -- Run test with output in a terminal split
  local cmd = string.format("./tools/execute_test.py -s %s", current_file)
  vim.cmd("split | terminal " .. cmd)
  vim.cmd("startinsert")
end

-- Track if already setup to avoid duplicate messages
local _setup_done = false

-- Setup keymaps
function M.setup()
  if _setup_done then
    return
  end

  vim.keymap.set("n", "<leader>tc", M.run_test, { desc = "Run test in container", silent = false })
  vim.keymap.set("n", "<leader>tC", M.run_test_with_output, { desc = "Run test with output", silent = false })

  _setup_done = true
  -- Only print once
  vim.notify("GameScanner keymaps loaded: <leader>tc, <leader>tC", vim.log.levels.INFO)
end

-- Auto-setup when in GameScanner repo
if is_gamescanner_repo() then
  M.setup()
end

return M
