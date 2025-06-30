return {
  "folke/snacks.nvim",
  opts = {
    zen = {
      enabled = true,
      toggles = {
        dim = false, -- enable background dimming
        git_signs = false,
        mini_diff_signs = false,
        diagnostics = false,
        inlay_hints = false,
      },
      zoom = {
        width = 80, -- center text with 80 character width
        height = 1, -- use full height
      },
      win = {
        backdrop = { transparent = false, blend = 95 }, -- dim the backdrop but keep text readable
        keys = {
          q = false, -- disable q to quit (optional)
        },
      },
      -- Override dim settings to only affect non-active areas
      dim = {
        enabled = false,
        alpha = 0.3, -- dim inactive areas
        -- Don't dim the actual text in the center pane
        inactivepanes = true,
      },
    },
  },
}
