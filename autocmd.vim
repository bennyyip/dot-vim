vim9script

# Functions [[[1
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
