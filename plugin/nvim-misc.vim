if exists("g:loaded_nvim_misc")
    finish
endif
let g:loaded_nvim_misc = 1

command OpenGithub lua require("open-github").openGithub()
command FmtCert lua require("fmt-cert").formatX509Cert()
command HighlightGroupViewer lua require("highlight-group-viewer").highlightGroupViewer()
command FmtJSONLogs lua require("json-logs").formatJSONLogs()

autocmd Filetype markdown.mdnotes lua require("mdnotes").defineKeywordReplacementCommands()
