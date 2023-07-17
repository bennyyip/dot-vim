vim9script
const is_win = has('win32')
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
  execute "py3file" $v .. "/vimrc.py"
endif

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
