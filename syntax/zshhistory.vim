" syntax highlighting for ZSH history
syn match even_date '^.*/.*[02468]/.*  '
syn match odd_date '^.*/.*[13579]/.*  '
hi def link odd_date Constant
hi def link even_date String
