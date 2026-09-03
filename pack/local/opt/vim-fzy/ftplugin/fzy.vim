vim9script
# ==============================================================================
# Run fzy asynchronously inside a Vim terminal-window
# File:         ftplugin/fzy.vim
# Author:       bfrg <https://github.com/bfrg>
# Website:      https://github.com/bfrg/vim-fzy
# Last Change:  Oct 21, 2022
# License:      Same as Vim itself (see :h license)
# ==============================================================================

tnoremap <silent> <buffer> <c-c> <c-w>:<c-u>call fzy#Stop()<cr>
if exists('&termwinkey') && (empty(&termwinkey) || &termwinkey =~? '<c-w>')
  tnoremap <buffer> <c-w> <c-w>.
endif

b:undo_ftplugin = 'execute "tunmap <buffer> <c-c>" | execute "tunmap <buffer> <c-w>"'
