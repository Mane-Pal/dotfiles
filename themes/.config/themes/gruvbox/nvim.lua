-- Gruvbox theme for Neovim (managed by geoloc-theme-set)
return {
  -- Install gruvbox colorscheme
  { "ellisonleao/gruvbox.nvim", priority = 1000 },

  -- Configure LazyVim to use gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}