local M = {}

-- markdownNotes provides highlighted keywords for bulleted note taking, as
-- inspired by the vim-notes plugin: https://github.com/xolox/vim-notes
function M.markdownNotes()
  -- needed for redrawing the multi-line highlight groups correctly. see `:h syn-sync-linebreaks`
  vim.cmd("syntax sync linebreaks=1")

  -- case sensitive matching
  vim.cmd("syntax case match")

  vim.cmd([[syntax match notesDoneItem ]] .. itemRegex("DONE"))
  vim.cmd([[syntax match notesDoneMarker /\<DONE\>/ containedin=notesDoneItem]])
  vim.api.nvim_set_hl(0, "notesDoneMarker", {link = "Question" })
  vim.api.nvim_set_hl(0, "notesDoneItem", {link = "Comment" })

  vim.cmd([[syntax match notesBlockedItem ]] .. itemRegex("BLOCKED"))
  vim.cmd([[syntax match notesBlockedMarker /\<BLOCKED\>/ containedin=notesBlockedItem]])
  vim.api.nvim_set_hl(0, "notesBlockedItem", {link = "Comment" })
  vim.api.nvim_set_hl(0, "notesBlockedMarker", {link = "Directory" })

  vim.cmd([[syntax match notesXXXItem ]] .. itemRegex("XXX"))
  vim.cmd([[syntax match notesXXXMarker /\<XXX\>/ containedin=notesXXXItem]])
  vim.api.nvim_set_hl(0, "notesXXXItem", {link = "Comment" })
  vim.api.nvim_set_hl(0, "notesXXXMarker", {link = "WarningMsg" })

  vim.cmd([[syntax match notesTodo /\<TODO\>/]])
  vim.api.nvim_set_hl(0, "notesTodo", {link = "WarningMsg" })

  vim.cmd([[syntax match notesInProgress /\<WIP\>/]])
  vim.api.nvim_set_hl(0, "notesInProgress", {link = "Directory" })

  defineKeywordReplacementCommands()
end

-- matches a bullet item
function itemRegex(word)
  return [[/^\(\s*\).*\<]] .. word .. [[\>.*\(\n\1\s.*\)*/]]
end

-- replaceKeyword replaces item keyword in the current line
function replaceKeyword(word)
  vim.cmd([[s/TODO\|WIP\|DONE\|XXX\|BLOCKED/]] .. word .. "/e")
  vim.cmd("noh")
end

function defineKeywordReplacementCommands()
  vim.api.nvim_create_user_command('Todo', [[lua replaceKeyword("TODO")]], {})
  vim.api.nvim_create_user_command('Wip', [[lua replaceKeyword("WIP")]], {})
  vim.api.nvim_create_user_command('Done', [[lua replaceKeyword("DONE")]], {})
  vim.api.nvim_create_user_command('Xxx', [[lua replaceKeyword("XXX")]], {})
  vim.api.nvim_create_user_command('Blocked', [[lua replaceKeyword("BLOCKED")]], {})
end

return M
