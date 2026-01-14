return {
  "folke/sidekick.nvim",
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
      cursor_agent = {
        cmd = { "cursor-agent" },
      },
      opencode = {
        cmd = { "opencode" },
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<c-.>",
      function()
        require("sidekick.cli").focus()
      end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Switch Focus",
    },
    -- Terminal mode navigation to escape AI pane
    { "<C-h>", "<C-\\><C-n><C-w>h", mode = "t", desc = "Navigate Left" },
    { "<C-j>", "<C-\\><C-n><C-w>j", mode = "t", desc = "Navigate Down" },
    { "<C-k>", "<C-\\><C-n><C-w>k", mode = "t", desc = "Navigate Up" },
    { "<C-l>", "<C-\\><C-n><C-w>l", mode = "t", desc = "Navigate Right" },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle({ focus = true })
      end,
      desc = "Sidekick Toggle CLI",
      mode = { "n", "v" },
    },
    {
      "<leader>au",
      function()
        require("sidekick.cli").toggle({ name = "cursor_agent", focus = true })
      end,
      desc = "Sidekick Cursor Agent Toggle",
      mode = { "n", "v" },
    },
    {
      "<leader>ao",
      function()
        require("sidekick.cli").toggle({ name = "opencode", focus = true })
      end,
      desc = "Sidekick OpenCode Toggle",
      mode = { "n", "v" },
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      desc = "Sidekick Ask Prompt",
      mode = { "n", "v" },
    },
  },
}
