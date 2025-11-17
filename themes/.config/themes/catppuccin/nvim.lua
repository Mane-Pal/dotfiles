-- Catppuccin Mocha theme for Neovim (managed by geoloc-theme-set)
return {
  -- Install catppuccin colorscheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Configure LazyVim to use catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}