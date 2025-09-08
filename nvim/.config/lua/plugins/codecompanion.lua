return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
      { "nvim-lua/plenary.nvim" },
      {
        "saghen/blink.cmp",
        lazy = false,
        version = "*",
        opts = {
          keymap = {
            preset = "enter",
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
          },
          cmdline = { sources = { "cmdline" } },
          sources = {
            default = { "lsp", "path", "buffer", "codecompanion" },
          },
        },
      },
    },
    opts = {
      strategies = {
        chat = {
          -- You can switch between "copilot" or "supermaven" here
          adapter = "copilot",
          -- adapter = "supermaven",
        },
        inline = {
          -- You can switch between "copilot" or "supermaven" here
          adapter = "copilot",
        },
      },
      opts = {
        log_level = "DEBUG",
      },
    },
  },
}
