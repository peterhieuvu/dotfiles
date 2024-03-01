return {
  { "folke/neodev.nvim", opts = {} },
  { 'norcalli/nvim-colorizer.lua',
    config = function ()
      require('colorizer').setup()
      vim.cmd[[ColorizerAttachToBuffer]]
    end
  }, -- adding color highlighter to css colors
  { 'nvim-colortils/colortils.nvim', config = true },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function ()
      local highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#9C7E81" })
          vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#BBAF98" })
          vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#99A5AF" })
          vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#B1A08F" })
          vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#ADB9A5" })
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#988C9B" })
          vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#92A7AA" })
      end)

      -- require("ibl").setup { indent = { highlight = highlight } }
      require("ibl").setup()
    end
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      require('which-key').setup()
      vim.o.timeout = true
      vim.o.timeoutlen = 300

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
    -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  --[[   { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  } ]]
  {
    "folke/tokyonight.nvim",
    lazy = false, -- load during startup since we need the theme right away
    priority = 1000, -- load this before all others
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  { 'numToStr/Comment.nvim', lazy = false, opts = {} },
  -- Highlight todo, notes, etc in comments
  {'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = true }},

  -- TODO: conform.nvim?
  -- TODO: vim-sleuth?

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.cursorword').setup()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]parenthen
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      --require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()


      -- Split and join lists from one line to multi line
      --
      -- Examples:
      --  - gS - toggle
      require('mini.splitjoin').setup()

      -- NOTE: consider:
      -- require('mini.pairs').setup()

      require('mini.move').setup({
        mappings = {
          left = '<M-H>',
          right = '<M-L>',
          down = '<M-J>',
          up = '<M-K>',

          line_left = '<M-H>',
          line_right = '<M-L>',
          line_down = '<M-J>',
          line_up = '<M-K>',
        }
      })

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      --require('mini.statusline').setup()

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    'jinh0/eyeliner.nvim',
    config = function ()
      require('eyeliner').setup {
        highlight_on_key = true,
        dim = false,
      }
    end,
  }
}

