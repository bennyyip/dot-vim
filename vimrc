vim9script
set nocompatible
filetype plugin indent on
syntax on

const is_win = has('win32')
g:minimal_plugins = v:false
$v = $HOME .. (is_win ? '\vimfiles' : '/.vim')
$VIMSTATE = $HOME .. '/.local/state/vim/'
$VIMRC = $v .. '/vimrc'
$RIPGREP_CONFIG_PATH = $HOME .. '/.ripgreprc'

g:mapleader   = "\<Space>"
g:localleader = "\\"

g:loaded_2html_plugin     = 1
g:loaded_getscriptPlugin  = 1
g:loaded_gzip             = 1
g:loaded_logiPat          = 1
g:loaded_manpager_plugin  = 1
# g:loaded_matchparen       = 1
g:loaded_rrhelper         = 1
g:loaded_spellfile_plugin = 1
g:loaded_tarPlugin        = 1
g:loaded_vimballPlugin    = 1
g:loaded_zipPlugin        = 1
g:loaded_netrw            = 1
g:loaded_netrwPlugin      = 1
g:loaded_tutor_mode_plugin = 1

g:load_black = 1
g:loaded_fzf = 1

if exists('#vimrc')
  augroup vimrc
    autocmd!
  augroup END
  augroup! vimrc
endif

source $v/setting.vim

if filereadable($HOME .. '/local.vim')
  source $HOME/local.vim
endif

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

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
