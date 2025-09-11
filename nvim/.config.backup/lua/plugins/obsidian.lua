return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  cmd = "Obsidian",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/notes/",
      },
      {
        name = "projects",
        path = "~/notes/projects",
      },
      {
        name = "archive",
        path = "~/notes/archive",
      },
    },

    -- Optional, if you keep notes in a specific subdirectory of your vault.
    notes_subdir = "0-inbox",

    -- Optional, customize how note IDs are generated given an optional title.
    note_id_func = function(title)
      -- Create note IDs with date for unique identification
      local suffix = ""
      if title ~= nil then
        -- Transform title into valid filename
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- Random suffix for untitled notes
        suffix = tostring(os.time())
      end
      return tostring(os.date("%Y-%m-%d")) .. "-" .. suffix
    end,

    ---- Optional, customize how note file names are generated given the ID, target directory, and title.
    --note_path_func = function(spec)
    --  -- Check if this is a daily note (YYYY-MM-DD format without suffix)
    --  if spec.id:match("^%d%d%d%d%-%d%d%-%d%d$") then
    --    -- This is a daily note, put it in the daily folder
    --    local daily_dir = spec.dir.root / "daily"
    --    return daily_dir / tostring(spec.id) .. ".md"
    --  else
    --    -- Regular note, use the configured notes_subdir
    --    local path = spec.dir / tostring(spec.id)
    --    return path:with_suffix(".md")
    --  end
    --end,

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
    new_notes_location = "notes_subdir",

    -- Optional, for templates (see below).
    templates = {
      subdir = "reference/templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    -- Daily notes configuration (using new_from_template approach instead)
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

    picker = {
      name = "telescope.nvim",
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
