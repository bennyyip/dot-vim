vim9script

# Functions [[[1
def JumpToLastPosition() # [[[2
  const last_pos = getpos("'\"")
  if last_pos[1] >= 1 && last_pos[1] <= line('$')
    setpos('.', getpos("'\""))
  endif
enddef

def SetTabWidth(n: number, expandtab: bool, softtabstop: number = -1) # [[[2
  execute $'setlocal shiftwidth={n} tabstop={n} softtabstop={softtabstop}'
  if expandtab
    setlocal expandtab
  else
    setlocal noexpandtab
  endif
enddef

# Autocmd [[[1
augroup vimrc
  autocmd FocusLost * :silent! wa
  autocmd FocusGained * silent! checktime
  autocmd TerminalWinOpen * setlocal nonu nornu nolist signcolumn=no
  autocmd BufReadPost * JumpToLastPosition()
augroup END

# FileType
for ft in ['vim', 'sh', 'zsh', 'bash', 'css', 'html', 'javascript', 'typescript']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: $'SetTabWidth(2, true)' }])
endfor

for ft in ['python']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: $'SetTabWidth(4, true)' }])
endfor

for ft in ['go']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: $'SetTabWidth(4, false)' }])
endfor

for ft in ['make']
  autocmd_add([{ event: 'FileType', pattern: ft, group: 'vimrc', cmd: $'SetTabWidth(8, false, 0)' }])
endfor

# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
