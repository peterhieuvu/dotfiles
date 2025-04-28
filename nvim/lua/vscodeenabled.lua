
if vim.g.vscode then
  print("NeoVim VSCode Enabled")

  local vscode = require('vscode')
  
  local function action(name)
    return function()
      vscode.action(name)
    end
  end
  
  local function call(name)
    return function()
      vscode.call(name)
    end
  end
  
  -- VSCode-specific keymaps for search and navigation
  vim.keymap.set("n", "<leader><space>", call('workbench.action.showAllEditors'))
  vim.keymap.set("n", "<leader>sf", "<cmd>Find<cr>")
  -- vim.keymap.set("n", "<leader>/", [[<cmd>lua require('vscode').action('workbench.action.findInFiles')<cr>]])
  vim.keymap.set("n", "<leader>sg", action('workbench.action.quickTextSearch'))
  vim.keymap.set("n", "<leader>ss", action('workbench.action.gotoSymbol'))

  -- Keep undo/redo lists in sync with VsCode
  -- vim.keymap.set("n", "u", call('undo'))
  -- vim.keymap.set("n", "<C-r>", call('redo'))

  -- Navigate VSCode tabs like lazyvim buffers
  vim.keymap.set("n", "<S-h>", call('workbench.action.previousEditor'))
  vim.keymap.set("n", "<S-l>", call('workbench.action.nextEditor'))
  
  -- yank to system clipboard
  vim.keymap.set({"n", "v"}, "<leader>y", '"+y', opts)

  -- paste from system clipboard
  vim.keymap.set({"n", "v"}, "<leader>p", '"+p', opts)
  
  vim.keymap.set("n", "gK", call('editor.action.triggerParameterHints'))

  
  -- TODO: == for reformating
  --[[
  keymap('n', '<Leader>xr', notify 'references-view.findReferences', { silent = true }) -- language references
  keymap('n', '<Leader>xd', notify 'workbench.actions.view.problems', { silent = true }) -- language diagnostics
  keymap('n', 'gr', notify 'editor.action.goToReferences', { silent = true })
  keymap('n', '<Leader>rn', notify 'editor.action.rename', { silent = true })
  keymap('n', '<Leader>fm', notify 'editor.action.formatDocument', { silent = true })
  keymap('n', '<Leader>ca', notify 'editor.action.refactor', { silent = true }) -- language code actions

  keymap('n', '<Leader>rg', notify 'workbench.action.findInFiles', { silent = true }) -- use ripgrep to search files
  keymap('n', '<Leader>ts', notify 'workbench.action.toggleSidebarVisibility', { silent = true })
  keymap('n', '<Leader>th', notify 'workbench.action.toggleAuxiliaryBar', { silent = true }) -- toggle docview (help page)
  keymap('n', '<Leader>tp', notify 'workbench.action.togglePanel', { silent = true })
  keymap('n', '<Leader>fc', notify 'workbench.action.showCommands', { silent = true }) -- find commands
  keymap('n', '<Leader>ff', notify 'workbench.action.quickOpen', { silent = true }) -- find files
  keymap('n', '<Leader>tw', notify 'workbench.action.terminal.toggleTerminal', { silent = true }) -- terminal window

  keymap('v', '<Leader>fm', v_notify 'editor.action.formatSelection', { silent = true })
  keymap('v', '<Leader>ca', v_notify 'editor.action.refactor', { silent = true })
  keymap('v', '<Leader>fc', v_notify 'workbench.action.showCommands', { silent = true })
  ]]--
  -- K - hover
  -- gd reveal definition
  -- gf reveal declaration
  -- gH reference search
  -- gO go to symbol
  -- gD peek definition
  -- gF peek declaration
  -- tab toggle peek focus
  
end
-- List of enabled plugins for vs code
return {
  "mini.nvim",
  "flash.nvim",
  -- yanky?
  -- "nvim-treesitter",
  -- "nvim-treesitter-textobjects",
  -- "nvim-ts-context-commentstring",
  -- "snacks.nvim",
  -- "ts-comments.nvim",
}