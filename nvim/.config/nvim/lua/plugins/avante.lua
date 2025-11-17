return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal_cmd = "SHELL=/bin/bash ~/.claude/local/claude", -- Point to local installation
    },
    config = true,
  },
}
