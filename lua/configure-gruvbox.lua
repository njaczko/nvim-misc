local M = {}

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

    " tree sitter overrides
    " jsonnet
    hi link @variable.jsonnet Normal
    hi link @field.jsonnet GruvboxRed
    hi link @punctuation.delimiter.jsonnet Normal
    hi link @punctuation.bracket.jsonnet Normal
    " json
    hi link @string.json Normal

    " markdown and markdown_inline
    hi link @punctuation.special.markdown GruvboxGray
    hi link @markup.list.markdown GruvboxGray
    hi link @markup.raw.markdown_inline GruvboxAqua " inline code blocks
    hi link @markup.link.label.markdown_inline GruvboxGray " URI references
    hi link @markup.link.url.markdown_inline GruvboxPurple " URI references

    " TODO I don't think we need these anymore. everything looks OK.
    " optimizing for backticks around inline code blocks. not great for italics and bold delmiters, but close enough
    "hi link @punctuation.delimiter.markdown_inline GruvboxAqua
    "hi link @punctuation.bracket.markdown_inline GruvboxGray " URI references
    "hi link @punctuation.delimiter.markdown GruvboxAqua " code blocks
    "hi link @text.literal.block.markdown Normal " code blocks
  ]])
end

return M