return {
  -- measure startup time with `nvim --startuptime`
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    },
        -- stylua: ignore
    keys = {
      { "<leader>ws", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>wl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>wd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  }
}
