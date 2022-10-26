local M = {}

-- TODO doc string
function M.formatX509Cert()
  max_length = 75
  wrapped_lines = {"-----BEGIN CERTIFICATE-----"}
  current_line = vim.api.nvim_get_current_line():gsub("^%s*", ""):gsub("%s*$", "")
  while string.len(current_line) > max_length do
    table.insert(wrapped_lines, current_line:sub(1,max_length))
    current_line = current_line:sub(max_length + 1, -1)
  end
  table.insert(wrapped_lines, current_line)
  table.insert(wrapped_lines, "-----END CERTIFICATE-----")

  vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), 0, -1, true, wrapped_lines)
end

return M
