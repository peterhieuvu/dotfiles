

local function visual_selection_range()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos "v") ---@type integer, integer, integer, integer
  local _, cerow, cecol, _ = unpack(vim.fn.getpos ".") ---@type integer, integer, integer, integer

  local start_row, start_col, end_row, end_col ---@type integer, integer, integer, integer

  if csrow < cerow or (csrow == cerow and cscol <= cecol) then
    start_row = csrow
    start_col = cscol
    end_row = cerow
    end_col = cecol
  else
    start_row = cerow
    start_col = cecol
    end_row = csrow
    end_col = cscol
  end

  return start_row, start_col, end_row, end_col
end

local function parent_range()
  if not require('nvim-treesitter.parsers').has_parser() then
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    return { row - 1, row + 1 } -- TODO: handle out of bounds?
  end

  local ts = require('nvim-treesitter.incremental_selection')
  ts.init_selection()
  ts.scope_incremental()

  local sr, _, er, _ = visual_selection_range()

  return { sr, er }
end

vim.keymap.set(
  'n',
  '<leader>=',
  function()
    local sr, er = unpack(parent_range())
    print(sr, er)
  end
)

if vim.g.vscode then
  print('NeoVim VSCode Enabled')

  local vscode = require('vscode')

  local function action(name)
    return function()
      vscode.action(name)
    end
  end

  local function call(name, opts)
    return function()
      vscode.call(name, opts)
    end
  end

  -- VSCode-specific keymaps for search and navigation
  vim.keymap.set('n', '<leader><space>', call('workbench.action.showAllEditors'))
  vim.keymap.set('n', '<leader>sf', "<cmd>Find<cr>")
  -- vim.keymap.set("n", "<leader>/", [[<cmd>lua require('vscode').action('workbench.action.findInFiles')<cr>]])
  vim.keymap.set('n', '<leader>sg', action('workbench.action.quickTextSearch'))
  vim.keymap.set('n', '<leader>ss', action('workbench.action.gotoSymbol'))

  -- Keep undo/redo lists in sync with VsCode
  -- vim.keymap.set("n", "u", call('undo'))
  -- vim.keymap.set("n", "<C-r>", call('redo'))
  vim.keymap.set('n', '<S-h>', call('workbench.action.previousEditor'))
  vim.keymap.set('n', '<S-l>', call('workbench.action.nextEditor'))

  -- yank to system clipboard
  -- vim.keymap.set({"n", "v"}, "<leader>y", '"+y')
  -- paste from system clipboard
  -- vim.keymap.set({"n", "v"}, "<leader>p", '"+p')

  vim.keymap.set('n', 'gK', call('editor.action.triggerParameterHints'))

  -- problem management
  vim.keymap.set('n', '<leader>sd', call('workbench.actions.view.problems'))
  vim.keymap.set('n', ']d', call('editor.action.marker.next'))
  vim.keymap.set('n', '[d', call('editor.action.marker.previous'))

  vim.keymap.set('n', '<leader>cr', call('editor.action.refactor'))
  vim.keymap.set('n', '<leader>ca', call('problems.action.showQuickFixes'))

  vim.keymap.set('n', '<leader>bd', call('workbench.action.closeWindow'))
  vim.keymap.set('n', '<leader>wo', call('workbench.action.files.openFile'))

  vim.keymap.set(
    'n',
    '==',
    function()
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      vim.cmd('normal! ^') -- go to the start of this line to ensure that we can look for the parent scope
      local sr, er = unpack(parent_range())
      if row - sr > 10 then
        sr = row - 10
      end
      if er - row > 10 then
        er = row + 10
      end
      vscode.action('editor.action.formatSelection', { range = {sr - 1, er - 1 }})

      vim.api.nvim_win_set_cursor(0, { row, col })
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'nx', false)
    end
  )

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
  'mini.nvim',
  'flash.nvim',
  -- yanky?
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  -- "snacks.nvim",
  -- "ts-comments.nvim",
}
