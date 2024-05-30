return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      direction = 'float'
    }
  },
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

      -- set up custom comment strings
      local ft = require('Comment.ft')

      ft.set('conf', '# %s')
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
}

