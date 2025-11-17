return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          exclude = { "*.png", "*.jpg", "*.jpeg" }, -- Ignore PNG and JPEG files
        },
      },
    },
    -- Enable GitHub integration
    gh = {
      enabled = true,
    },
    -- Enable Linear integration
    linear = {
      enabled = true,
    },
  },
  keys = {
    -- GitHub issue/PR browsing
    {
      "<leader>gi",
      function()
        Snacks.picker.gh_issue()
      end,
      desc = "GitHub Issues (Open)",
    },
    {
      "<leader>gI",
      function()
        Snacks.picker.gh_issue({ state = "all" })
      end,
      desc = "GitHub Issues (All)",
    },
    {
      "<leader>gp",
      function()
        Snacks.picker.gh_pr()
      end,
      desc = "GitHub Pull Requests (Open)",
    },
    {
      "<leader>gP",
      function()
        Snacks.picker.gh_pr({ state = "all" })
      end,
      desc = "GitHub Pull Requests (All)",
    },
  },
}
