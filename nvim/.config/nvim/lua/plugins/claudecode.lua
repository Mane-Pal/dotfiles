return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal_cmd = "claude",
  },
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Claude Code Toggle", mode = { "n", "v" } },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code Focus" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", desc = "Claude Code Send Selection", mode = "v" },
  },
  config = true,
}
