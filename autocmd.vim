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

def HighlightOnYank(timeout: number)
  const operator = v:event.operator
  const regtype = v:event.regtype
  const regcontents = v:event.regcontents
  if v:event.operator != 'y' || (empty(v:event.regtype))
    return
  endif

  const is_visual = v:event.visual

  const start = is_visual ? (getpos("'<")) : (getpos("'["))
  const start_line = start[1]
  const start_col = start[2]
  const end_line = is_visual ? (getpos("'>")[1]) : (getpos("']")[1])
  const shift = start_line == end_line ? start_col - 1 : 0
  const length = len(v:event.regcontents[-1]) + 1 + shift
  const bufnr = str2nr(expand('<abuf>'))

  prop_add(start_line, start_col, {
    end_lnum: end_line, end_col: length, type: 'yank_prop'
  })

  timer_start(timeout, (_) => {
    prop_remove({bufnr: bufnr, type: 'yank_prop', all: true}, start_line, end_line)
  })
enddef

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
  autocmd TextYankPost * HighlightOnYank(500)
  autocmd BufReadPost * JumpToLastPosition()
augroup END

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
