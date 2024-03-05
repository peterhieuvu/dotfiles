-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

-- Set highlight on search
-- vim.opt.hlsearch = false

-- Line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Don't show the mode since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.opt.clipboard = 'unnamedplus'

-- Continue indents with line breaks
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching unless \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set sign column
vim.opt.signcolumn = 'yes'

-- Decrease update time
-- vim.opt.updatetime = 250
-- vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '~', lead = '.', nbsp = '␣' }

-- ??
vim.opt.inccommand = 'split'

-- Highlight current line
vim.opt.cursorline = true

-- Min number of screen lines to keep above and below cursor
vim.opt.scrolloff = 10

-- Set completeopt to have a better completion experience
-- Set in nvim-cmp??? TODO
vim.opt.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

-- TODO consider vim-sleuth?
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.smartindent = true

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

