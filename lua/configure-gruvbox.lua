local M = {}



-- configureGruvbox provides my custom configuration and overrides for the
-- Gruvbox colorscheme (https://github.com/morhetz/gruvbox).
--
-- To use this configuration with Gruvbox, add the following to the lazy.nvim package manager config:
-- {
--   "morhetz/gruvbox",
--   lazy = false, priority = 1000, -- make sure to load this before all the other start plugins
--   dependencies = {
--     "njaczko/nvim-misc", -- provides gruvbox configuration
--   },
--   config = function()
--     require("configure-gruvbox").configureGruvbox()
--   end,
-- },
function M.configureGruvbox()
  vim.cmd([[
    " this needs to be called before colorscheme. override colorscheme and use
    " black background
    au ColorScheme * hi Normal guibg=NONE ctermbg=NONE
    " we need this in 0.10, which enables termguicolors by default. Gruvbox doesn't look good with tgc.
    set notgc

    colorscheme gruvbox

    highlight clear SignColumn " no background for line numbers
    " dark gray highlight for folded lines
    highlight Folded guibg=#404040
    highlight clear LineNr
    highlight clear CursorLineNr

    " auto highlight keywords. needs to be called after colorscheme stuff
    hi YellowBG ctermbg=3 guibg=yellow guifg=black ctermfg=black
    " incomplete n char easymotion search
    hi EasyMotionIncSearch ctermbg=none ctermfg=red
    call matchadd('YellowBG', '<Paste>')
    call matchadd('YellowBG', 'TODO')

    " nested bullets are confused for code blocks because they start with many
    " spaces. code fenced with backticks is still highlighted.
    highlight link markdownCodeBlock Normal
    " some things that are technically invalid markdown syntax (like unescaped
    " underscores) don't really cause issues for my use cases. the error
    " highlights are more of a nuisance than a help for me.
    autocmd FileType markdown hi link markdownError Normal
    autocmd FileType markdown hi link htmlError Normal

    " tree sitter overrides
    " jsonnet
    hi link @variable.jsonnet Normal
    hi link @field.jsonnet GruvboxRed
    hi link @punctuation.delimiter.jsonnet Normal
    hi link @punctuation.bracket.jsonnet Normal
    " json
    hi link @string.json Normal
    " yaml
    hi link @string.yaml Normal

    " markdown and markdown_inline
    hi link @punctuation.special.markdown GruvboxGray
    hi link @markup.list.markdown GruvboxGray
    hi link @markup.raw.markdown_inline GruvboxAqua " inline code blocks
    hi link @markup.link.label.markdown_inline GruvboxGray " URI references
    hi link @markup.link.url.markdown_inline GruvboxPurple " URI references
  ]])
end

return M
