return {
  -- Linear CLI integration for Neovim
  {
    dir = "/home/manepal/git/mane-pal/linear-cli.nvim",
    name = "linear-cli.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Enhanced UI for issue selection
    },
    cmd = {
      "LinearSetup",
      "LinearAuth",
      "LinearSync",
      "LinearBrowse", 
      "LinearSearch",
      "LinearConfig",
      "LinearBranch",
    },
    keys = {
      { "<leader>lS", "<cmd>LinearSetup<cr>", desc = "Linear: Setup integration" },
      { "<leader>la", "<cmd>LinearAuth<cr>", desc = "Linear: Test authentication" },
      { "<leader>ls", "<cmd>LinearSync<cr>", desc = "Linear: Sync issues" },
      { "<leader>lb", "<cmd>LinearBrowse<cr>", desc = "Linear: Browse local issues" },
      { "<leader>lf", "<cmd>LinearSearch<cr>", desc = "Linear: Search all issues" },
      { "<leader>lg", "<cmd>LinearBranch<cr>", desc = "Linear: Create git branch" },
      { "<leader>lc", "<cmd>LinearConfig<cr>", desc = "Linear: Config (init/edit/show)" },
    },
    config = function()
      require("linear").setup({
        -- CLI command (if not in PATH, use full path)
        cli_cmd = "linear",
        
        -- Enable default keymaps (set to false if you prefer the above keys)
        default_keymaps = false, -- We're using explicit keys above
        
        -- Telescope configuration
        telescope = {
          theme = "dropdown",
          layout_opts = {
            width = 0.9,
            height = 0.7,
          },
        },
        
        -- Auto-sync issues when starting Neovim
        auto_sync = false, -- Set to true if you want automatic syncing
        
        -- Issue file handling
        issues = {
          -- Auto-open issue file after creating branch
          auto_open_on_branch = true,
          -- File extension for issue files
          file_extension = ".md",
        },
      })
    end,
  },
}