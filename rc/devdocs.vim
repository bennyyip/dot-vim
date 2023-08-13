vim9script

import autoload "../autoload/utils.vim" as Utils

nmap gK <Plug>(devdocs-under-cursor)
vnoremap <silent> gK :call <SID>DevdocsQueryVisualSelection()<CR>

def DevdocsQueryVisualSelection()
  const selection = Utils.GetVisualSelection()
  devdocs#open(selection, &l:ft)
enddef

# nnoremap <silent><Plug>(devdocs-under-cursor) :<C-u>call devdocs#open(expand('<cword>'), &l:ft)<CR>
