-- LongLines flattens the selected range (or the whole file if no range is selected) into one long line.
vim.api.nvim_create_user_command(
  'LongLines',
  function(opts)
    local original_tw = vim.o.tw
    vim.o.tw = 999999999
    if opts.range > 0 then
      -- A range was provided, only format that range
      vim.cmd(string.format('normal! %dGV%dGgq', opts.line1, opts.line2))
    else
      -- No range provided, format the whole buffer
      vim.cmd.normal('ggVGgq')
    end
    vim.o.tw = original_tw
  end,
  { range = true }
)
