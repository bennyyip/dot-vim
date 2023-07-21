vim9script
const is_win = has('win32')
g:minimal_plugins = v:false
$v = $HOME .. (is_win ? '\vimfiles' : '/.vim')
$VIMRC = $v .. '/vimrc'

def Source(file: string)
  execute $'source $v/{file}.vim'
enddef

if exists('#vimrc')
  augroup vimrc
    autocmd!
  augroup END
  augroup! vimrc
endif

Source('setting')
Source('pack')
Source('ui')
Source('command')
Source('keymap')
Source('autocmd')
if is_win
  Source('windows')
else
  Source('unix')
endif

if filereadable($HOME .. '/local.vim')
  source $HOME/local.vim
endif


if has("python3")
  execute "py3file" $v .. "/vimrc.py"
endif

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
