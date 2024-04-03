return {
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
        symbols = {
          encode = MiniMap.gen_encode_symbols.block('2x2')
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
  }
}
