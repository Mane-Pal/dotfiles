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
  },
}
