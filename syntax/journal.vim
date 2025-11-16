" syntax highlighting for a YAML-style journal
syn match date /\d\{4}-\d\{2}-\d\{2}:/
hi def link date Delimiter
syn match Comment '#.*'
