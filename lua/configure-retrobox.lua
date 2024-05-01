local M = {}

function M.configureRetrobox()
  vim.cmd([[
    " this needs to be called before colorscheme. override colorscheme and use
    " black background
    au ColorScheme * hi Normal guibg=NONE ctermbg=NONE
    " we need this in 0.10, which enables termguicolors by default.
    set notgc

    colorscheme retrobox

    " TODO see if we get more robust parity between gruvbox and retrobox without all these overrides
    " NOTE: these are redundant for gruvbox, but make retrobox match gruvbox.
    highlight Normal ctermfg=223 guifg=#ebdbb2 " GruvboxFg1
    highlight Ignore ctermfg=223 guifg=#ebdbb2 " GruvboxFg1
    highlight Keyword ctermfg=167 guifg=#fb4934 " GruvboxRed
    highlight Conditional ctermfg=167 guifg=#fb4934 " GruvboxRed
    highlight Repeat ctermfg=167 guifg=#fb4934 " GruvboxRed
    highlight Statement ctermfg=167 guifg=#fb4934 " GruvboxRed
    highlight Label ctermfg=167 guifg=#fb4934 " GruvboxRed
    highlight SpecialChar ctermfg=167 guifg=#fb4934 " GruvboxRed
    highlight StatusLine cterm=reverse ctermfg=239 ctermbg=223 gui=bold,reverse guifg=#ebdbb2 guibg=#ebdbb2
    highlight Pmenu ctermfg=223 ctermbg=237 guifg=#ebdbb2 guibg=#3c3836
    highlight TabLineSel cterm=bold ctermfg=223 ctermbg=234 gui=bold guifg=#fbf1c7 guibg=#1c1c1c
    highlight CurSearch ctermfg=0 ctermbg=11 guifg=NvimDarkGrey1 guibg=NvimLightYellow
    highlight Search cterm=reverse ctermfg=214 ctermbg=235 gui=reverse guifg=#fabd2f guibg=#282828
    highlight DiffAdd cterm=reverse ctermfg=142 ctermbg=235 gui=reverse guifg=#b8bb26 guibg=#282828
    highlight DiffChange cterm=reverse ctermfg=108 ctermbg=235 gui=reverse guifg=#8ec07c guibg=#282828
    highlight DiffDelete cterm=reverse ctermfg=167 ctermbg=235 gui=reverse guifg=#fb4934 guibg=#282828
    highlight Added ctermfg=142 guifg=#b8bb26 " GruvboxGreen
    highlight Removed ctermfg=167 guifg=#fb4934 " GruvboxRed
    highlight WarningMsg ctermfg=167 guifg=#fb4934 " GruvboxRed
    highlight ErrorMsg cterm=bold ctermfg=234 ctermbg=167 gui=bold guifg=#1c1c1c guibg=#fb4934 " GruvboxRed background
    highlight Error cterm=bold ctermfg=234 ctermbg=167 gui=bold guifg=#1c1c1c guibg=#fb4934 " GruvboxRed background

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
    hi link @field.jsonnet Keyword
    hi link @punctuation.delimiter.jsonnet Normal
    hi link @punctuation.bracket.jsonnet Normal
    " json
    hi link @string.json Normal

    " markdown and markdown_inline
    hi @punctuation.special.markdown ctermfg=245 guifg=#928374 " GruvboxGray
    hi @markup.list.markdown ctermfg=245 guifg=#928374 " GruvboxGray
    hi @markup.raw.markdown_inline ctermfg=108 guifg=#8ec07c " inline code blocks. GruvboxAqua
    hi @markup.link.label.markdown_inline ctermfg=245 guifg=#928374 " URI references. GruvboxGray
    hi @markup.link.url.markdown_inline ctermfg=175 guifg=#d3869b " URI references. GruvboxPurple

    " make visual selection background use same color as the syntax highlighting
    hi! Visual cterm=reverse ctermfg=none ctermbg=Black
  ]])
end

-- FYI, here are the Gruvbox colors for future override reference:
-- GruvboxFg0     ctermfg=229 guifg=#fbf1c7
-- GruvboxFg1     ctermfg=223 guifg=#ebdbb2
-- GruvboxFg2     ctermfg=250 guifg=#d5c4a1
-- GruvboxFg3     ctermfg=248 guifg=#bdae93
-- GruvboxFg4     ctermfg=246 guifg=#a89984
-- GruvboxGray    ctermfg=245 guifg=#928374
-- GruvboxBg0     ctermfg=235 guifg=#282828
-- GruvboxBg1     ctermfg=237 guifg=#3c3836
-- GruvboxBg2     ctermfg=239 guifg=#504945
-- GruvboxBg3     ctermfg=241 guifg=#665c54
-- GruvboxBg4     ctermfg=243 guifg=#7c6f64
-- GruvboxRed     ctermfg=167 guifg=#fb4934
-- GruvboxRedBold cterm=bold ctermfg=167 gui=bold guifg=#fb4934
-- GruvboxGreen   ctermfg=142 guifg=#b8bb26
-- GruvboxGreenBold cterm=bold ctermfg=142 gui=bold guifg=#b8bb26
-- GruvboxYellow  ctermfg=214 guifg=#fabd2f
-- GruvboxYellowBold cterm=bold ctermfg=214 gui=bold guifg=#fabd2f
-- GruvboxBlue    ctermfg=109 guifg=#83a598
-- GruvboxBlueBold cterm=bold ctermfg=109 gui=bold guifg=#83a598
-- GruvboxPurple  ctermfg=175 guifg=#d3869b
-- GruvboxPurpleBold cterm=bold ctermfg=175 gui=bold guifg=#d3869b
-- GruvboxAqua    ctermfg=108 guifg=#8ec07c
-- GruvboxAquaBold cterm=bold ctermfg=108 gui=bold guifg=#8ec07c
-- GruvboxOrange  ctermfg=208 guifg=#fe8019
-- GruvboxOrangeBold cterm=bold ctermfg=208 gui=bold guifg=#fe8019
-- GruvboxRedSign ctermfg=167 ctermbg=237 guifg=#fb4934 guibg=#3c3836
-- GruvboxGreenSign ctermfg=142 ctermbg=237 guifg=#b8bb26 guibg=#3c3836
-- GruvboxYellowSign ctermfg=214 ctermbg=237 guifg=#fabd2f guibg=#3c3836
-- GruvboxBlueSign ctermfg=109 ctermbg=237 guifg=#83a598 guibg=#3c3836
-- GruvboxPurpleSign ctermfg=175 ctermbg=237 guifg=#d3869b guibg=#3c3836
-- GruvboxAquaSign ctermfg=108 ctermbg=237 guifg=#8ec07c guibg=#3c3836
-- GruvboxOrangeSign ctermfg=208 ctermbg=237 guifg=#fe8019 guibg=#3c3836

return M
