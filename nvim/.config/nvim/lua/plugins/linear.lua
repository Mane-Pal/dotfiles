return {
  -- snacks-linear: Linear integration using snacks.nvim
  {
    dir = "/home/manepal/git/mane-pal/snacks-linear",
    name = "snacks-linear",
    dependencies = {
      "folke/snacks.nvim",
    },
    cmd = {
      "LinearIssues",
      "LinearTeams",
      "LinearProjects",
      "LinearProjectsAll",
      "LinearSearch",
      "LinearSearchProjects",
      "LinearIssue",
      "LinearCreate",
      "LinearClearCache",
    },
    keys = {
      -- Issue browsing (using <leader>l - lowercase l for Linear, easier to type!)
      {
        "<leader>ll",
        function()
          require("snacks-linear").pick_issues()
        end,
        desc = "Linear: List all issues (searchable)",
      },
      {
        "<leader>li",
        function()
          require("snacks-linear").pick_issues({ state = { "started", "unstarted" } })
        end,
        desc = "Linear: Issues (todo/in-progress)",
      },
      {
        "<leader>lm",
        function()
          require("snacks-linear").pick_issues({ assignee = "me" })
        end,
        desc = "Linear: My assigned issues",
      },
      {
        "<leader>lt",
        function()
          require("snacks-linear").pick_teams()
        end,
        desc = "Linear: Browse teams",
      },
      {
        "<leader>lp",
        function()
          require("snacks-linear").pick_projects()
        end,
        desc = "Linear: Browse projects (active)",
      },
      {
        "<leader>lpa",
        function()
          require("snacks-linear").browse_projects({ include_completed = true })
        end,
        desc = "Linear: Browse all projects (including completed)",
      },
      -- Search
      {
        "<leader>lsi",
        function()
          require("snacks-linear").search_issues()
        end,
        desc = "Linear: Search issues by title",
      },
      {
        "<leader>lsp",
        function()
          require("snacks-linear").search_projects()
        end,
        desc = "Linear: Search projects by name",
      },
      -- Issue creation
      {
        "<leader>ln",
        function()
          require("snacks-linear").create_issue()
        end,
        desc = "Linear: Create new issue",
      },
      -- Utilities
      {
        "<leader>lc",
        "<cmd>LinearClearCache<cr>",
        desc = "Linear: Clear cache",
      },
    },
    config = function()
      require("snacks-linear").setup({
        -- Set your default team key here (optional)
        -- team = "ENG", -- Uncomment and set your team key

        -- Cache settings
        cache_ttl = 300, -- 5 minutes

        -- Custom icons (optional)
        -- icons = {
        --   logo = "▲",
        -- },

        -- Custom keymaps for issue buffers (optional)
        -- keys = {
        --   comment = { "a", "linear_comment", desc = "Add Comment" },
        --   close = { "c", "linear_close", desc = "Close" },
        -- },
      })
    end,
  },
}