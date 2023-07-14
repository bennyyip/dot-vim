let s:is_gvim = has('gui_running')

set iminsert=2
let &pythonthreedll = expand(substitute(exepath('python.exe'), 'python.exe', 'python3[0-9][0-9].dll', ''))
let &pythonthreehome = substitute(exepath('python.exe'), 'python.exe', '', '')
let g:netrw_cygwin = 0
let g:netrw_silent = 1

if s:is_gvim
  augroup vimrc
    autocmd GUIEnter *  simalt ~x
  augroup END
  set guioptions-=egmrLtT
  set guifont=Sarasa\ Term\ CL\ Nerd:h14
  " 調整行高
  set linespace=-2
endif

