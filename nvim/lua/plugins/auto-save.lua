
return {
  "okuuva/auto-save.nvim",
  version = "^1.0.0", -- use the latest major version
  cmd = "ASToggle", -- optional: lazy load on this command
  event = { "InsertLeave", "TextChanged" }, -- optional: lazy load on these events
  opts = {
    -- specific options if you need them
    enabled = true, -- start auto-save when the plugin is loaded
    trigger_events = { -- See :h events
      immediate_save = { "BufLeave", "FocusLost" }, -- raizes save immediately
      defer_save = { "InsertLeave", "TextChanged" }, -- saves after a delay
    },
    debounce_delay = 135, -- save delay in ms
  },
}
