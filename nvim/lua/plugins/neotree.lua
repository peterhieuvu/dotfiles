return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        event = 'VeryLazy',
        config = function()
            require 'window-picker'.setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = { 'terminal', "quickfix" },
                    },
            },
        })
        end,
      },
    },
    config = function ()
      vim.fn.sign_define("DiagnosticSignError",
        {text = " ", texthl = "DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn",
        {text = " ", texthl = "DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo",
        {text = " ", texthl = "DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint",
        {text = "󰌵", texthl = "DiagnosticSignHint"})

      require("neo-tree").setup({
        popup_border_style = "rounded",
        source_selector = {
          winbar = true
        },
        sources = { "filesystem", "buffers", "git_status", "document_symbols" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },

      })
    end,
    keys = {
      {
        "\\",
        function ()
          require("neo-tree.command").execute({ toggle = true })
        end,
        desc = "Toggle tree"
      },
      {
        "|",
        function ()
          require("neo-tree.command").execute({ position = "left", reveal = true })
        end,
        desc = "Toggle tree in sidebar"
      },
      {
        "<C-\\>",
        function ()
          require("neo-tree.command").execute({ position = "current", reveal_force_cwd = true })
        end,
        desc = "Toggle tree in current window"
      },
      {
        "<leader>x",
        function ()
          require("neo-tree.command").execute({ position = "float", reveal_force_cwd = true })
        end,
        desc = "Show floating file e[X]plorer"
      },
      {
        "<leader>bb",
        function ()
          require("neo-tree.command").execute({ toggle = true, action = "show", source = "buffers", position = "right" })
        end,
        desc = "Toggle buffer view on right"
      },
      {
        "<leader>gg",
        function ()
          require("neo-tree.command").execute({ position = "float", source = "git_status" })
        end,
        desc = "Show floating git tree"
      }
    }
  },
  -- nnoremap / :Neotree toggle current reveal_force_cwd<cr>
  -- nnoremap | :Neotree reveal<cr>
  -- nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
  -- nnoremap <leader>b :Neotree toggle show buffers right<cr>
  -- nnoremap <leader>s :Neotree float git_status<cr>
};
