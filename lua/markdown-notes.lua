local M = {}

-- TODO doc string
function M.markdownNotes()
  -- vim.api.nvim_set_hl(0, "your-group", { link = "another-group" })
  -- vim.cmd('echo 42')
  vim.cmd('syntax sync linebreaks=1')

  -- TODO dry up regexes with string interpolation?
  vim.cmd('syntax match notesDoneItem /^\(\s\+\).*\<DONE\>.*\(\n\1\s.*\)*/')
  vim.cmd('syntax match notesDoneMarker /\<DONE\>/ containedin=notesDoneItem')
  vim.api.nvim_set_hl(0, "Comment", {link = "notesDoneItem" })
  vim.api.nvim_set_hl(0, "Question", {link = "notesDoneMarker" })


  vim.cmd('syntax match notesBlockedItem /^\(\s\+\).*\<BLOCKED\>.*\(\n\1\s.*\)*/')
  vim.cmd('syntax match notesBlockedMarker /\<BLOCKED\>/ containedin=notesBlockedItem')
  vim.api.nvim_set_hl(0, "Comment", {link = "notesBlockedItem" })
  vim.api.nvim_set_hl(0, "Directory", {link = "notesBlockedMarker" })

  vim.cmd('syntax match notesXXXItem /^\(\s\+\).*\<XXX\>.*\(\n\1\s.*\)*/')
  vim.cmd('syntax match notesXXXMarker /\<XXX\>/ containedin=notesXXXItem')
  vim.api.nvim_set_hl(0, "Comment", {link = "notesXXXItem" })
  vim.api.nvim_set_hl(0, "WarningMsg", {link = "notesXXXMarker" })

  vim.cmd('syntax match notesTodo /\<TODO\>/')
  vim.cmd('syntax match notesInProgress /\<WIP\>/')
  vim.api.nvim_set_hl(0, "WarningMsg", {link = "notesTodo" })
  vim.api.nvim_set_hl(0, "Directory", {link = "notesInProgress" })
end

return M
