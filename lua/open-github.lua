local M = {}

-- openGithub opens the current line in the browser in github.com. It's a bit
-- fragile: the repo must have been cloned from GitHub using SSH. Opening a
-- range of lines is not supported.
function M.openGithub()
  local function exec(cmd)
    -- shell out then strip trailing whitespace
    output = vim.call('system', cmd):gsub("%s*$", "")
    if (vim.v.shell_error ~= 0) then error(string.format("'%s' failed: %s", cmd, output)) end
    return output
  end

  -- assumes the repo was cloned with SSH rather than HTTPS.
  originURL  = exec('git remote get-url origin'):gsub("git@github.com:", "https://github.com/"):gsub("%.git", "")
  defaultBranch = exec("git remote show origin | sed -n '/HEAD branch/s/.*: //p'")
  pathInRepo = exec(string.format("git ls-files --full-name %s", vim.fn.expand('%')))
  currentLineNum = unpack(vim.api.nvim_win_get_cursor(0))
  githubURL = string.format("%s/blob/%s/%s#L%s", originURL, defaultBranch, pathInRepo, currentLineNum)
  exec(string.format('open "%s"', githubURL))
end

return M
