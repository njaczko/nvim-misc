local M = {}

-- formatJSONLogs turns a file in which each line is a JSON object into a JSON array
function M.formatJSONLogs()
  line_count = vim.api.nvim_buf_line_count(0)
  lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)

  for i=1,line_count-1,1 do
    -- don't modify empty lines
    if (lines[i] ~= '' and lines[i] ~= nil) then
      lines[i] = lines[i] .. ","
    end
  end
  table.insert(lines, 1, "[")
  table.insert(lines, "]")

  vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)

  vim.api.nvim_set_option_value("filetype", "json", {})
end

return M
