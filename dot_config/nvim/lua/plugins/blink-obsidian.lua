-- Integration between blink.cmp and obsidian.nvim
return {
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      -- Only modify sources if we're in a notes workspace
      -- Keep default sources same as main config: lsp, path, buffer, codecompanion
      -- Obsidian.nvim will handle its own completion internally
      return opts
    end,
  },
}