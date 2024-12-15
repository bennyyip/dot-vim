vim9script
g:vimsuggest_fzfindprg = 'fd --type f .'
g:vimsuggest_findprg = 'fd --type f'
g:vimsuggest_grepprg = 'rg --vimgrep --smart-case $* .'

var vim_suggest = {}
vim_suggest.cmd = {'pum': v:true, 'alwayson': v:false}
vim_suggest.search = {'pum': v:true, 'prefixlen': 0, 'alwayson': v:false}
call g:VimSuggestSetOptions(vim_suggest)
