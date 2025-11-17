-- GameScanner-specific keymaps for container testing and debugging
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>c", group = "container" },
      },
    },
  },
  {
    "nvim-dap",
    keys = {
      {
        "<leader>td",
        function()
          local current_file = vim.fn.expand("%:p")
          local filename = vim.fn.expand("%:t")

          -- Check if it's a test file
          if not (filename:match("^test_") or current_file:match("/test")) then
            vim.notify("Not a test file: " .. filename, vim.log.levels.WARN)
            return
          end

          -- Detect service from path to determine the correct debug port
          -- API: 5300, Data preprocessing: 5301, GameScanner: 5302, Analytics: 5303
          local service_port_map = {
            api = 5300,
            data_preprocessing = 5301,
            gamescanner = 5302,
            analytics = 5303,
          }

          local service = "api" -- default
          for svc, _ in pairs(service_port_map) do
            if current_file:match("/" .. svc) then
              service = svc
              break
            end
          end

          local port = service_port_map[service]

          -- Start test with debugger
          local cmd = string.format(
            "cd %s && ./tools/execute_test.py --debug %s",
            vim.fn.getcwd(),
            current_file
          )

          vim.notify(
            string.format("Starting %s test with debugger on port %d...", service, port),
            vim.log.levels.INFO
          )

          vim.fn.jobstart(cmd, {
            on_stdout = function(_, data)
              for _, line in ipairs(data) do
                if line:match("Waiting for debugger") then
                  vim.notify("Debugger ready, attaching...", vim.log.levels.INFO)
                end
              end
            end,
          })

          -- Wait for debugpy to start, then manually attach to correct port
          vim.defer_fn(function()
            local dap = require("dap")
            dap.run({
              type = "python",
              request = "attach",
              name = "Attach to container test",
              connect = {
                host = "localhost",
                port = port,
              },
              pathMappings = {
                {
                  localRoot = vim.fn.getcwd() .. "/services",
                  remoteRoot = "/usr/src/app",
                },
              },
            })
          end, 2500)
        end,
        desc = "Debug test in container",
      },
    },
  },
}
