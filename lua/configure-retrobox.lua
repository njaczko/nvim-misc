local M = {}

-- openGithub opens the current line in the browser in github.com. It's a bit
-- fragile: the repo must have been cloned from GitHub using SSH. Opening a
-- range of lines is not supported.
function M.configureRetrobox()
  vim.cmd([[
    " this needs to be called before colorscheme. override colorscheme and use
    " black background
    au ColorScheme * hi Normal guibg=NONE ctermbg=NONE
    " we need this in 0.10, which enables termguicolors by default.
    set notgc

    colorscheme retrobox

    " NOTE: these are redundant for gruvbox, but make retrobox match gruvbox.
    highlight Normal ctermfg=223 guifg=#ebdbb2 " GruvboxFg1
    highlight Ignore ctermfg=223 guifg=#ebdbb2 " GruvboxFg1
    highlight Keyword ctermfg=167 guifg=#fb4934 " GruvboxRed
    highlight StatusLine cterm=reverse ctermfg=239 ctermbg=223 gui=bold,reverse guifg=#ebdbb2 guibg=#ebdbb2
    highlight Pmenu ctermfg=223 ctermbg=237 guifg=#ebdbb2 guibg=#3c3836

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


    " tree sitter overrides
    " jsonnet
    hi link @variable.jsonnet Normal
    hi link @field.jsonnet Keyword
    hi link @punctuation.delimiter.jsonnet Normal
    hi link @punctuation.bracket.jsonnet Normal
    " json
    hi link @string.json Normal

    hi @punctuation.special.markdown ctermfg=245 guifg=#928374 " GruvboxGray
    hi @markup.list.markdown ctermfg=245 guifg=#928374 " GruvboxGray
    hi @markup.raw.markdown_inline ctermfg=108 guifg=#8ec07c " inline code blocks. GruvboxAqua
    hi @markup.link.label.markdown_inline ctermfg=245 guifg=#928374 " URI references. GruvboxGray
    hi @markup.link.url.markdown_inline ctermfg=175 guifg=#d3869b " URI references. GruvboxPurple
  ]])
end

return M
