let g:vimsuggest_fzfindprg = 'fd --type f .'
let g:vimsuggest_findprg = 'fd --type f'
let g:vimsuggest_grepprg = 'rg --vimgrep --smart-case $* .'

let s:vim_suggest = {}
let s:vim_suggest.cmd = {'pum': v:true}
let s:vim_suggest.search = {'pum': v:true}
call g:VimSuggestSetOptions(s:vim_suggest)
