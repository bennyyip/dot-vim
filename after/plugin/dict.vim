" Plugin: iamcco/dict.vim
if !ben#has_plugin('dict.vim')
  finish
endif

nmap <silent> <Leader>oy <Plug>DictSearch
xmap <silent> <Leader>oy <Plug>DictVSearch
nmap <silent> <Leader>oY <Plug>DictWSearch
xmap <silent> <Leader>oY <Plug>DictWVSearch
