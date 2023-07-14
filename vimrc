let g:is_ssh = ($SSH_CONNECTION != "")
let s:is_win = has('win32')
let s:is_tty = !match(&term, 'linux')
let s:is_gvim = has('gui_running')
let s:is_nvim = has('nvim')
let $v = $HOME.(s:is_win ? '\vimfiles' : '/.vim')
let $VIMRC = $v . '/vimrc'

if has("python3")
  exe "py3file" $v . "/vimrc.py"
endif

execute 'source ' . $v . "/setting.vim"
execute 'source ' . $v . "/pack.vim"
execute 'source ' . $v . "/ui.vim"
execute 'source ' . $v . "/command.vim"
execute 'source ' . $v . "/keymap.vim"
if s:is_win
  execute 'source ' . $v . "/windows.vim"
else
  execute 'source ' . $v . "/unix.vim"
endif

if filereadable($HOME. '/local.vim')
  source $HOME/local.vim
endif

" vim:fdm=marker:fmr=[[[,]]]:ft=vim
