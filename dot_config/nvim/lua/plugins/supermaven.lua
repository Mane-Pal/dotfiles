return {
  "supermaven-inc/supermaven-nvim",
  event = "VeryLazy",
  opts = {},
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<M-l>", -- Use Alt-l to accept suggestion
        clear_suggestion = "<C-]>", -- Default: clear suggestion
        accept_word = "<C-j>", -- Default: accept word
      },
      -- Add any other options you want below
      log_level = "info",
      disable_inline_completion = false,
      disable_keymaps = false,
      -- condition = function() return false end, -- Optional: custom stop condition
    })
  end,
}
