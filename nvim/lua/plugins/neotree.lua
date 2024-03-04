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
      require("neo-tree").setup({
        popup_border_style = "rounded"
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
        "<leader>b",
        function ()
          require("neo-tree.command").execute({ toggle = true, action = "show", source = "buffers", position = "right" })
        end,
        desc = "Toggle buffer view on right"
      },
      {
        "<leader>g",
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
