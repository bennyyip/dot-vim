vim9script
set nocompatible
syntax on

const is_win = has('win32')
g:minimal_plugins = v:false
$v = $HOME .. (is_win ? '\vimfiles' : '/.vim')
$vimtmp = $HOME .. '/.config/vimtmp/'
$VIMRC = $v .. '/vimrc'

g:mapleader = "\<Space>"
g:localleader = "\\"

g:loaded_2html_plugin = 1
g:loaded_getscriptPlugin = 1
g:loaded_gzip = 1
g:loaded_logiPat = 1
g:loaded_logipat = 1
g:loaded_manpager_plugin = 1
# let g:loaded_matchparen = 1
g:loaded_rrhelper = 1
g:loaded_spellfile_plugin = 1
g:loaded_tarPlugin = 1
g:loaded_vimballPlugin = 1
g:loaded_zipPlugin = 1

g:load_black = 1
g:loaded_fzf = 1

set list listchars=tab:▸\ ,nbsp:␣,trail:⣿,extends:…,precedes:… showbreak=↪
set number relativenumber cursorline cursorlineopt=number signcolumn=number

if exists('#vimrc')
  augroup vimrc
    autocmd!
  augroup END
  augroup! vimrc
endif

source $v/keymap.vim
source $v/pack.vim

set background=dark
try
  colorscheme gruvbox8_hard
catch
  try
    colorscheme retrobox
  catch
    colorscheme elflord
  endtry
endtry

def Init(..._: list<any>)
  filetype plugin indent on
  source $v/setting.vim

  hi StartifyHeader ctermfg=214 ctermbg=NONE guifg=#fabd2f guibg=NONE guisp=NONE cterm=NONE gui=NONE

  if filereadable($HOME .. '/local.vim')
    source $HOME/local.vim
  endif
enddef

if is_win
  Init()
else
  timer_start(0, Init)
endif
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
