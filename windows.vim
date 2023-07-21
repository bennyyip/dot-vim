vim9script
const is_gvim = has('gui_running')

set renderoptions=type:directx
set iminsert=2
&pythonthreedll = expand(substitute(exepath('python.exe'), 'python.exe', 'python3[0-9][0-9].dll', ''))
&pythonthreehome = substitute(exepath('python.exe'), 'python.exe', '', '')
g:netrw_cygwin = 0
g:netrw_silent = 1

if is_gvim
  augroup vimrc
    autocmd GUIEnter *  ++once simalt ~x
  augroup END
  set guifont=Sarasa\ Term\ CL\ Nerd:h14
  # 調整行高
  set linespace=-2
endif
