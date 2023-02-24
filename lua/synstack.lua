local M = {}

-- synstack returns a list of the syntax groups matching the cursor location.
-- It is useful for debugging syntax highlighting. see `:h synstack` for more info.
function M.synstack()
  -- TODO can we use more lua here?
  vim.cmd([[echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')]])
end

return M
