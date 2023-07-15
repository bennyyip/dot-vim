vim9script
g:is_ssh = ($SSH_CONNECTION != "")
const is_win = has('win32')
const is_tty = !match(&term, 'linux')
const is_gvim = has('gui_running')
const is_nvim = has('nvim')
g:minimal_plugins = v:false
$v = $HOME .. (is_win ? '\vimfiles' : '/.vim')
$VIMRC = $v .. '/vimrc'

if filereadable($HOME .. '/local.vim')
  source $HOME/local.vim
endif

execute 'source ' .. $v .. "/setting.vim"
execute 'source ' .. $v .. "/pack.vim"
execute 'source ' .. $v .. "/ui.vim"
execute 'source ' .. $v .. "/command.vim"
execute 'source ' .. $v .. "/keymap.vim"
if is_win
  execute 'source ' .. $v .. "/windows.vim"
else
  execute 'source ' .. $v .. "/unix.vim"
endif


if has("python3")
  exe "py3file" $v .. "/vimrc.py"
endif

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
