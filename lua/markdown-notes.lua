local M = {}

-- TODO doc string
function M.markdownNotes()
  vim.cmd('syntax sync linebreaks=1')

  -- TODO dry up regexes with string interpolation?
  vim.cmd([[syntax match notesDoneItem /^\(\s\+\).*\<DONE\>.*\(\n\1\s.*\)*/]])
  vim.cmd([[syntax match notesDoneMarker /\<DONE\>/ containedin=notesDoneItem]])
  vim.api.nvim_set_hl(0, "notesDoneMarker", {link = "Question" })
  vim.api.nvim_set_hl(0, "notesDoneItem", {link = "Comment" })

  vim.cmd([[syntax match notesBlockedItem /^\(\s\+\).*\<BLOCKED\>.*\(\n\1\s.*\)*/]])
  vim.cmd([[syntax match notesBlockedMarker /\<BLOCKED\>/ containedin=notesBlockedItem]])
  vim.api.nvim_set_hl(0, "notesBlockedItem", {link = "Comment" })
  vim.api.nvim_set_hl(0, "notesBlockedMarker", {link = "Directory" })

  vim.cmd([[syntax match notesXXXItem /^\(\s\+\).*\<XXX\>.*\(\n\1\s.*\)*/]])
  vim.cmd([[syntax match notesXXXMarker /\<XXX\>/ containedin=notesXXXItem]])
  vim.api.nvim_set_hl(0, "notesXXXItem", {link = "Comment" })
  vim.api.nvim_set_hl(0, "notesXXXMarker", {link = "WarningMsg" })

  vim.cmd([[syntax match notesTodo /\<TODO\>/]])
  vim.cmd([[syntax match notesInProgress /\<WIP\>/]])
  vim.api.nvim_set_hl(0, "notesTodo", {link = "WarningMsg" })
  vim.api.nvim_set_hl(0, "notesInProgress", {link = "Directory" })
end

return M
