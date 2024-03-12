return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async"
    },
    config = function ()
      -- folding
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldcolumn = '0'
      vim.opt.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      })
    end
  },
  --   -- search/replace in multiple files
  -- {
  --   "nvim-pack/nvim-spectre",
  --   build = false,
  --   cmd = "Spectre",
  --   opts = { open_cmd = "noswapfile vnew" },
  --   -- stylua: ignore
  --   keys = {
  --     { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
  --   },
  -- },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>tx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>tX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>tL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>tQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              ---@diagnostic disable-next-line
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },
  { 'NvChad/nvim-colorizer.lua',
    config = function ()
      require('colorizer').setup({
        user_default_options = {
          mode = "virtualtext" -- background, foreground
        }
      })
      vim.cmd[[ColorizerAttachToBuffer]]
    end
  }, -- adding color highlighter to css colors
  { 'nvim-colortils/colortils.nvim', config = true },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function ()
      require("ibl").setup({
        scope = { enabled = false },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      })
    end
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
        ["g"] = { name = "+[g]oto" },
        ["gs"] = { name = "+[s]urround" },
        ["]"] = { name = "+[n]ext" },
        ["["] = { name = "+[p]rev" },
        ["<leader><tab>"] = { name = "+[t]abs" },
        ["<leader>b"] = { name = "+[b]uffer" },
        ["<leader>c"] = { name = "+[c]ode", _ = 'which_key_ignore' },
        -- ["<leader>f"] = { name = "+[f]ile/find" },
        ["<leader>g"] = { name = "+[g]it" },
        ["<leader>gh"] = { name = "+[g]it [h]unks" },
        ["<leader>q"] = { name = "+[q]uit/session" },
        ["<leader>s"] = { name = "+[s]earch" },
        ["<leader>u"] = { name = "+[u]i" },
        ["<leader>w"] = { name = "+[w]indows/workspace" },
        ["<leader>t"] = { name = "+[t]rouble/diagnostics/quickfix" },

        ['<leader>d'] = { name = '[d]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[r]ename', _ = 'which_key_ignore' },
        -- ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        -- ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>n'] = { name = '[n]oice', _ = 'which_key_ignore'},
        -- ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore'},
        -- ['<leader>gh'] = { name = '[G]it [H]unk', _ = 'which_key_ignore'},
      }
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
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
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
      show_end_of_buffer = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
   -- comments
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function ()
      ---@diagnostic disable-next-line missing-fieldss
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    cmd = { "TodoTrouble", "TodoTelescope" },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = true },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>tt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>tT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    }
  },

  -- TODO: conform.nvim?
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          ---@diagnostic disable-next-line inject-field
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function()
      require('mini.cursorword').setup()
      require("mini.bufremove").setup()

      local MiniMap = require('mini.map')
      MiniMap.setup({
        integrations = {
          require('mini.map').gen_integration.diagnostic({
            error = 'DiagnosticFloatingError',
            warn  = 'DiagnosticFloatingWarn',
            info  = 'DiagnosticFloatingInfo',
            hint  = 'DiagnosticFloatingHint',
          }),
          require('mini.map').gen_integration.builtin_search()
        },
        window = {
          width = 10,
          zindex = 21,
          show_integration_count = false
        }
      })
      vim.keymap.set('n', '<Leader>mc', MiniMap.close)
      vim.keymap.set('n', '<Leader>mf', MiniMap.toggle_focus)
      vim.keymap.set('n', '<Leader>mo', MiniMap.open)
      vim.keymap.set('n', '<Leader>mr', MiniMap.refresh)
      vim.keymap.set('n', '<Leader>ms', MiniMap.toggle_side)
      vim.keymap.set('n', '<Leader>mt', MiniMap.toggle)
      vim.api.nvim_create_autocmd('TabEnter', {
        desc = 'Testing',
        callback = function()
          require('mini.map').open()
        end,
      })


      vim.keymap.set("n", "<leader>bd",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end, { desc = "Delete Buffer" })
      vim.keymap.set("n", "<leader>bD", function() require("mini.bufremove").delete(0, true) end, { desc = "Delete Buffer (Force)" })
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]parenthen
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup({
        mappings = {
          add = "gsa", -- Add surrounding in Normal and Visual modes
          delete = "gsd", -- Delete surrounding
          find = "gsf", -- Find surrounding (to the right)
          find_left = "gsF", -- Find surrounding (to the left)
          highlight = "gsh", -- Highlight surrounding
          replace = "gsr", -- Replace surrounding
          update_n_lines = "gsn", -- Update `n_lines`
        },
      })


      -- Split and join lists from one line to multi line
      --
      -- Examples:
      --  - gS - toggle
      require('mini.splitjoin').setup({
        mappings = {
          toggle = '<leader>cs'
        }
      })

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

      require("mini.indentscope").setup({
        options = {
          try_as_border = true,
        },
        symbol = "│",
        draw = {
          animation = require('mini.indentscope').gen_animation.none()
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
}

