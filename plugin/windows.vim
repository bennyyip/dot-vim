vim9script
if !has('win32') | finish | endif
const is_gvim = has('gui_running')

if has('directx')
  set renderoptions=type:directx
endif

$SHELL = 'bash'
# set shell=$SHELL

set shellslash
set completeslash=slash

set iminsert=2
&pythonthreedll = expand(substitute(exepath('python.exe'), 'python.exe', 'python3[0-9][0-9].dll', ''))
&pythonthreehome = substitute(exepath('python.exe'), 'python.exe', '', '')

g:netrw_cygwin = 0
g:netrw_silent = 1

set cryptmethod=xchacha20v2
