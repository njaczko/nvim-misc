if exists("g:loaded_nvim_misc")
    finish
endif
let g:loaded_nvim_misc = 1

command! OpenGithub lua require("open-github").openGithub()

command! FmtCert lua require("fmt-cert").formatX509Cert()

command! MarkdownNotes lua require("markdown-notes").markdownNotes()
autocmd FileType markdownnotes lua require("markdown-notes").markdownNotes()
