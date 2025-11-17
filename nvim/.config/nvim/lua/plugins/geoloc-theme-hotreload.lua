-- Geoloc theme hotreload plugin
-- Automatically applies colorscheme when running :Lazy reload
return {
  {
    name = "geoloc-theme-hotreload",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    priority = 1000,
    config = function()
      -- Watch for LazyReload event and apply new colorscheme
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyReload",
        callback = function()
          -- Clear the theme module cache
          package.loaded["plugins.theme"] = nil

          -- Reload the theme spec
          local ok, theme_spec = pcall(require, "plugins.theme")
          if ok and theme_spec then
            -- Find the colorscheme in the theme spec
            for _, spec in ipairs(theme_spec) do
              if spec[1] == "LazyVim/LazyVim" and spec.opts and spec.opts.colorscheme then
                local colorscheme = spec.opts.colorscheme

                -- Apply colorscheme in next tick to escape autocmd context
                vim.defer_fn(function()
                  -- Load the colorscheme plugin if needed
                  require("lazy.core.loader").colorscheme(colorscheme)

                  -- Apply the colorscheme
                  pcall(vim.cmd.colorscheme, colorscheme)

                  vim.notify("Applied colorscheme: " .. colorscheme, vim.log.levels.INFO)
                end, 0)
                break
              end
            end
          end
        end,
      })
    end,
  },
}
