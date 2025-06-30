return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/notes",
      },
      {
        name = "scratch",
        path = "~/scratch",
      },
      {
        name = "drafts",
        path = "~/drafts",
      },
    },

    -- Optional, customize how note IDs are generated given an optional title.
    note_id_func = function(title)
      -- Create note IDs with timestamp for unique identification
      local suffix = ""
      if title ~= nil then
        -- Transform title into valid filename
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- Random suffix for untitled notes
        suffix = tostring(os.time())
      end
      return tostring(os.date("%Y%m%d%H%M")) .. "-" .. suffix
    end,

    -- Optional, customize how note file names are generated given the ID, target directory, and `note_id_func`.
    note_path_func = function(spec)
      -- Store notes in appropriate subdirectories based on title/content
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md")
    end,

    -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
    open_app_foreground = false,

    -- Optional, configure key mappings for the plugin. These are the defaults.
    -- If you don't want to set any keymappings this way then set 'mappings = {}'.
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
    },

    -- Optional, customize how names/IDs for new notes are created.
    new_notes_location = "0-inbox",

    -- Optional, for templates (see below).
    templates = {
      subdir = "reference/templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    -- Daily notes configuration
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = "daily.md",
    },

    -- Optional, completion of wiki links, local markdown links, and tags using blink.cmp.
    completion = {
      nvim_cmp = false, -- We're using blink.cmp, not nvim-cmp
      min_chars = 2,
    },

    -- Optional, configure additional syntax highlighting / extmarks.
    ui = {
      enable = true, -- set to false to disable all additional syntax features
      update_debounce = 200, -- update delay after a text change (in milliseconds)
      -- Define how various check-boxes are displayed
      checkboxes = {
        -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      },
    },
  },
}

