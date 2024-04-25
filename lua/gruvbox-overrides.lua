local M = {}

-- openGithub opens the current line in the browser in github.com. It's a bit
-- fragile: the repo must have been cloned from GitHub using SSH. Opening a
-- range of lines is not supported.
function M.configureGruvbox()
  vim.cmd([[
    " this needs to be called before colorscheme. override colorscheme and use
    " black background
    au ColorScheme * hi Normal guibg=NONE ctermbg=NONE
    " we need this in 0.10, which enables termguicolors by default. Gruvbox doesn't look good with tgc.
    set notgc

    colorscheme gruvbox

    " NOTE: this is redundant for gruvbox, but makes retrobox match gruvbox.
    highlight Normal ctermfg=223 guifg=#ebdbb2

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
    hi link markdownError Normal
    " syntax highlighting inside code blocks. can add more languages, these are
    " just ones that I use often and have verified the highlighting works
    " correctly
    "" TODO I commented this out because I don't think that we'll need it very
    "" often now that treesitter is taking care of more syntax highlighting for
    "" me. startuptime is much better without this.
    "let g:markdown_fenced_languages = ['go', 'vim', 'bash', 'sql', 'json']

    " tree sitter overrides
    " jsonnet
    hi link @variable.jsonnet Normal
    hi link @field.jsonnet GruvboxRed
    hi link @punctuation.delimiter.jsonnet Normal
    hi link @punctuation.bracket.jsonnet Normal
    " json
    hi link @string.json Normal

    " NOTE: I've disabled treesitter markdown highlighting for now so that we can
    " keep using markdown_fenced_languages. Otherwise, markdown highlighting looks
    " good with these overrides
    "
    " markdown and markdown_inline
    hi link @punctuation.special.markdown GruvboxGray
    hi link @markup.list.markdown GruvboxGray
    " NOTE: now there arent separate highlight groupts for the # and the rest of the heading so the override isn't useful
    hi link @markup.heading.1.markdown GruvboxOrange " header markers
    hi link @markup.heading.2.markdown GruvboxOrange
    hi link @markup.heading.3.markdown GruvboxOrange
    hi link @markup.heading.4.markdown GruvboxOrange
    hi link @markup.raw.markdown_inline GruvboxAqua " inline code blocks
    " TODO review the rest of the overrides. treesitter has changed the groups
    " optimizing for backticks around inline code blocks. not great for italics and bold delmiters, but close enough
    hi link @punctuation.delimiter.markdown_inline GruvboxAqua
    hi link @text.reference.markdown_inline GruvboxGray " URI references
    hi link @text.uri.markdown_inline GruvboxPurple " URI references
    hi link @punctuation.bracket.markdown_inline GruvboxGray " URI references
    hi link @punctuation.delimiter.markdown GruvboxAqua " code blocks
    hi link @text.literal.block.markdown Normal " code blocks
  ]])
end

return M
