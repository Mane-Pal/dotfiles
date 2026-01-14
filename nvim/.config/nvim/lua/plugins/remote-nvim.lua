return {
  "amitds1997/remote-nvim.nvim",
  version = "*", -- Pin to latest release
  dependencies = {
    "nvim-lua/plenary.nvim", -- For standard functions
    "MunifTanjim/nui.nvim", -- For UI
    "nvim-telescope/telescope.nvim", -- Optional, for remote selection
  },
  config = function()
    require("remote-nvim").setup({
      -- Configuration for SSH connections
      ssh_config = {
        -- Automatically use your ~/.ssh/config
        ssh_config_file_paths = { "$HOME/.ssh/config" },
        -- Supports ProxyJump, Include, and other SSH config directives
      },
      
      -- Remote installation settings
      remote = {
        app_name = "nvim", -- This will be used for remote installation
        -- Copy your local Neovim config to remote
        copy_dirs = {
          config = {
            base = vim.fn.stdpath("config"), -- ~/.config/nvim
            dirs = "*", -- Copy everything
            compression = {
              enabled = true,
            },
          },
          data = {
            base = vim.fn.stdpath("data"), -- ~/.local/share/nvim
            dirs = {
              "lazy", -- Copy lazy.nvim and installed plugins
            },
            compression = {
              enabled = true,
            },
          },
          cache = {
            base = vim.fn.stdpath("cache"), -- ~/.cache/nvim
            dirs = "*",
            compression = {
              enabled = true,
            },
          },
          state = {
            base = vim.fn.stdpath("state"), -- ~/.local/state/nvim
            dirs = "*",
            compression = {
              enabled = true,
            },
          },
        },
      },

      -- Client configuration (local machine)
      client_callback = function(port, _)
        -- This callback is run when remote server starts
        -- You can customize connection behavior here
        local cmd = ("wezterm cli set-tab-title 'Remote: %s'"):format(vim.g.remote_neovim_host or "")
        vim.fn.system(cmd)
      end,

      -- Neovim installation on remote
      neovim_install_script_path = vim.fn.stdpath("data") .. "/remote-nvim/scripts/neovim_install.sh",
      
      -- Offline mode support (if remote doesn't have GitHub access)
      offline_mode = {
        enabled = false, -- Set to true if your remote servers don't have internet
        no_github = false, -- Set to true to avoid GitHub entirely
      },

      -- Logging
      log = {
        level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
        max_size = 1024 * 1024 * 2, -- 2MB
        float_handler = true, -- Show logs in floating window
      },
    })
  end,
  
  -- Keymaps for remote-nvim
  keys = {
    {
      "<leader>rc",
      "<cmd>RemoteStart<cr>",
      desc = "Remote: Connect to server",
    },
    {
      "<leader>rs",
      "<cmd>RemoteStop<cr>",
      desc = "Remote: Stop connection",
    },
    {
      "<leader>ri",
      "<cmd>RemoteInfo<cr>",
      desc = "Remote: Connection info",
    },
    {
      "<leader>rl",
      "<cmd>RemoteLog<cr>",
      desc = "Remote: Show logs",
    },
    {
      "<leader>rC",
      "<cmd>RemoteCleanup<cr>",
      desc = "Remote: Cleanup stale sessions",
    },
    {
      "<leader>rd",
      "<cmd>RemoteConfigDel<cr>",
      desc = "Remote: Delete saved connection",
    },
  },
}
