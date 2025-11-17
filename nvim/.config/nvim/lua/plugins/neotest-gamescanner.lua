-- Neotest configuration for GameScanner
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-python",
  },
  opts = function()
    return {
      adapters = {
        require("neotest-python")({
          runner = "pytest",
          -- Override the command to use execute_test.py
          pytest_discover_instances = true,
          -- Custom args to make it work with containers
          args = { "-v" },
        }),
      },
      -- Show output window for failed tests
      output = {
        open_on_run = false,
      },
      -- Customize status signs
      status = {
        enabled = true,
        virtual_text = true,
      },
    }
  end,
  keys = {
    -- Override default keymaps to use execute_test.py
    {
      "<leader>tc",
      function()
        local current_file = vim.fn.expand("%:p")
        local filename = vim.fn.expand("%:t")

        -- Check if it's a test file
        if not (filename:match("^test_") or current_file:match("/test")) then
          vim.notify("Not a test file: " .. filename, vim.log.levels.WARN)
          return
        end

        -- Run test
        local cmd = string.format("!%s/tools/execute_test.py %s", vim.fn.getcwd(), current_file)
        vim.cmd(cmd)
      end,
      desc = "Run test file in container",
    },
    {
      "<leader>tC",
      function()
        local current_file = vim.fn.expand("%:p")
        local filename = vim.fn.expand("%:t")

        -- Check if it's a test file
        if not (filename:match("^test_") or current_file:match("/test")) then
          vim.notify("Not a test file: " .. filename, vim.log.levels.WARN)
          return
        end

        -- Run test with output
        local cmd = string.format("!%s/tools/execute_test.py -s %s", vim.fn.getcwd(), current_file)
        vim.cmd(cmd)
      end,
      desc = "Run test with output",
    },
  },
}
