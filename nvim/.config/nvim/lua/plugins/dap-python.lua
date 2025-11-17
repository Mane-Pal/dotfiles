-- DAP Python configuration for GameScanner container debugging
return {
  "mfussenegger/nvim-dap-python",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    local dap = require("dap")

    -- Setup dap-python (uses system python for now)
    require("dap-python").setup("python")

    -- Add container debugging configurations
    table.insert(dap.configurations.python, {
      type = "python",
      request = "attach",
      name = "Attach to Test (port 5301)",
      connect = {
        host = "localhost",
        port = 5301,
      },
      pathMappings = {
        {
          localRoot = vim.fn.getcwd() .. "/services",
          remoteRoot = "/usr/src/app",
        },
      },
    })

    table.insert(dap.configurations.python, {
      type = "python",
      request = "attach",
      name = "Attach to API Service (port 5678)",
      connect = {
        host = "localhost",
        port = 5678,
      },
      pathMappings = {
        {
          localRoot = vim.fn.getcwd() .. "/services",
          remoteRoot = "/usr/src/app",
        },
      },
    })

    table.insert(dap.configurations.python, {
      type = "python",
      request = "attach",
      name = "Attach to Data Preprocessing (port 5679)",
      connect = {
        host = "localhost",
        port = 5679,
      },
      pathMappings = {
        {
          localRoot = vim.fn.getcwd() .. "/services",
          remoteRoot = "/usr/src/app",
        },
      },
    })

    table.insert(dap.configurations.python, {
      type = "python",
      request = "attach",
      name = "Attach to GameScanner (port 5680)",
      connect = {
        host = "localhost",
        port = 5680,
      },
      pathMappings = {
        {
          localRoot = vim.fn.getcwd() .. "/services",
          remoteRoot = "/usr/src/app",
        },
      },
    })

    table.insert(dap.configurations.python, {
      type = "python",
      request = "attach",
      name = "Attach to Analytics (port 5681)",
      connect = {
        host = "localhost",
        port = 5681,
      },
      pathMappings = {
        {
          localRoot = vim.fn.getcwd() .. "/services",
          remoteRoot = "/usr/src/app",
        },
      },
    })
  end,
}
