
require("keymaps")
require("vimoptions")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local enabled = require("vscodeenabled")

require("lazy").setup("plugins", {
  defaults = {
    -- by default, use the enabled list to restrict plugin loading if we are in vs code
    cond = vim.g.vscode and function(plugin)
      return vim.tbl_contains(enabled, plugin.name)
    end or nil,  
  }
})

if not vim.g.vscode then
  vim.cmd[[colorscheme catppuccin]]
end
