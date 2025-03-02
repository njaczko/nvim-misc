local M = {}

-- formatX509Cert assumes that the current file is an x509 certificate. The
-- "BEGIN" or "END" delimiters are optional. It formats the certificate without
-- verifying it.
function M.formatX509Cert()
  max_line_length = 75
  vim.cmd([[normal ggVGgJ]]) -- join the whole cert into one line
  current_line = vim.api.nvim_get_current_line()
    :gsub("%-%-%-%-%-BEGIN CERTIFICATE%-%-%-%-%-", "")
    :gsub("%-%-%-%-%-END CERTIFICATE%-%-%-%-%-"  , "")
    :gsub("%s", "")

  wrapped_lines = {"-----BEGIN CERTIFICATE-----"}
  while string.len(current_line) > max_line_length do
    table.insert(wrapped_lines, current_line:sub(1,max_line_length))
    current_line = current_line:sub(max_line_length + 1, -1)
  end
  table.insert(wrapped_lines, current_line)
  table.insert(wrapped_lines, "-----END CERTIFICATE-----")

  vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), 0, -1, true, wrapped_lines)
end

return M
