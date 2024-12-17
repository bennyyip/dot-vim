vim9script
g:vimsuggest_fzfindprg = 'fd --type f .'
g:vimsuggest_findprg = 'fd --type f'
g:vimsuggest_grepprg = 'rg --vimgrep --smart-case $* .'

var vim_suggest = {}
vim_suggest.cmd = { 'enable': v:true, 'trigger': 'n', 'pum': v:true, 'prefixlen': 2, 'alwayson': v:false }
vim_suggest.search = { 'enable': v:true, 'pum': v:true, 'prefixlen': 2, 'alwayson': v:false}
call g:VimSuggestSetOptions(vim_suggest)
