if exists("g:loaded_nvim_misc")
    finish
endif
let g:loaded_nvim_misc = 1

command OpenGithub lua require("open-github").openGithub()
command FmtCert lua require("fmt-cert").formatX509Cert()
command FmtJSONLogs lua require("json-logs").formatJSONLogs()

lua require("long-lines")

" These commands rely on Go executables that can be built in this repo. Don't
" forget to `go install` them.
command -range ExtendJournal <line1>,<line2>!extendjournal
" Example of a command that will pipe the selection and pass args when it shells out:
 command -range -nargs=* Go <line1>,<line2>!example <args>


autocmd Filetype markdown.mdnotes lua require("mdnotes").defineKeywordReplacementCommands()
