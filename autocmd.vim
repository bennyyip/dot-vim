vim9script

# Functions [[[1
# HighlightOnYank [[[2
if empty(prop_type_get('yank_prop'))
  prop_type_add('yank_prop', {
    highlight: "QuickFixLine",
    combine: true,
    priority: 100,
  })
endif

def JumpToLastPosition() # [[[2
  const last_pos = getpos("'\"")
  if last_pos[1] >= 1 && last_pos[1] <= line('$')
    setpos('.', getpos("'\""))
  endif
enddef

# Autocmd [[[1
augroup vimrc
  autocmd FocusGained * silent! checktime
  autocmd TerminalWinOpen * setlocal nonu nornu nolist signcolumn=no
  autocmd BufReadPost * JumpToLastPosition()
augroup END

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
