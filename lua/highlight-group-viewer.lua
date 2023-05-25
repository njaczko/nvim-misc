M = {}

local builtin_groups = {
  "ColorColumn", "Conceal", "CurSearch", "Cursor", "CursorColumn", "CursorIM",
  "CursorLine", "CursorLineFold", "CursorLineNr", "CursorLineSign", "DiffAdd",
  "DiffChange", "DiffDelete", "DiffText", "Directory", "EndOfBuffer", "ErrorMsg",
  "FoldColumn", "Folded", "IncSearch", "LineNr", "LineNrAbove", "LineNrBelow",
  "MatchParen", "ModeMsg", "MoreMsg", "MsgArea", "MsgSeparator", "NonText",
  "Normal", "NormalFloat", "NormalNC", "Pmenu", "PmenuSbar", "PmenuSel",
  "PmenuThumb", "Question", "QuickFixLine", "Search", "SignColumn", "SpecialKey",
  "SpellBad", "SpellCap", "SpellLocal", "SpellRare", "StatusLine",
  "StatusLineNC", "Substitute", "TabLine", "TabLineFill", "TabLineSel",
  "TermCursor", "TermCursorNC", "Title", "Visual", "VisualNOS", "WarningMsg",
  "Whitespace", "WildMenu", "WinBar", "WinBarNC", "WinSeparator", "lCursor",
}

-- highlightGroupViewer displays builtin highlighting groups (see :h
-- highlight-groups) and their configured highlighting.
function M.highlightGroupViewer()
  -- TODO open fresh buffer and write to it rather than using the current buffer

  for k,v in pairs(builtin_groups) do
    vim.cmd(
      [[syntax match ]] .. v .. [[ /\<]] .. v .. [[\>/]]
    )
  end

  vim.api.nvim_buf_set_lines(0, 0, 0, true, builtin_groups)
  -- wrap lines
  vim.api.nvim_feedkeys('gggqG' , 'n', true)
end

return M
