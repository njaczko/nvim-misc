local M = {}

-- replaceKeyword replaces item keyword in the current line
function replaceKeyword(word)
  vim.cmd([[s/TODO\|WIP\|DONE\|XXX\|BLOCKED\|WAITING/]] .. word .. "/e")
  vim.cmd("noh")
end

function M.defineKeywordReplacementCommands()
  vim.api.nvim_create_user_command('Todo', [[lua replaceKeyword("TODO")]], {})
  vim.api.nvim_create_user_command('Wip', [[lua replaceKeyword("WIP")]], {})
  vim.api.nvim_create_user_command('Done', [[lua replaceKeyword("DONE")]], {})
  vim.api.nvim_create_user_command('Xxx', [[lua replaceKeyword("XXX")]], {})
  vim.api.nvim_create_user_command('Blocked', [[lua replaceKeyword("BLOCKED")]], {})
  vim.api.nvim_create_user_command('Waiting', [[lua replaceKeyword("WAITING")]], {})
end

return M
