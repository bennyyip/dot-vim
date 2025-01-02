vim9script
const is_win = has('win32')
g:minimal_plugins = v:false
$v = $HOME .. (is_win ? '\vimfiles' : '/.vim')
$vimtmp = $HOME .. '/.config/vimtmp/'
$VIMRC = $v .. '/vimrc'

if exists('#vimrc')
  augroup vimrc
    autocmd!
  augroup END
  augroup! vimrc
endif

if filereadable($HOME .. '/local.vim')
  source $HOME/local.vim
endif

source $v/setting.vim
source $v/pack.vim

set background=dark
try
  colorscheme gruvbox8_hard
catch
  try
    colorscheme retrobox
  endtry
endtry

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
