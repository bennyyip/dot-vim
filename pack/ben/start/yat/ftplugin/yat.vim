vim9script

if exists("b:did_ftplugin")
    finish
endif
b:did_ftplugin = 1

var undo_opts = "setl spell< buftype< bufhidden< buflisted< swapfile< list< number< relativenumber< statusline<"

setlocal nospell
setlocal buftype=nofile
setlocal bufhidden=wipe
setlocal nobuflisted
setlocal noswapfile
setlocal nolist
setlocal nonumber norelativenumber
setlocal statusline=\ YAT

var nop_maps = []
var undo_maps = []

b:undo_ftplugin = undo_opts .. ' | '
b:undo_ftplugin ..= (nop_maps + undo_maps)->mapnew((_, v) => $'exe "unmap <buffer> {v}"')->join(' | ')


const padding_left = get(g:, 'yat_padding_left', 3)
const left_pad = repeat(' ', padding_left)
const fixed_column = padding_left + 2

b:oldline = 0
def SetCursor()
  var newline = line('.')

  if newline < b:oldline
    while (b:yat_section_header_lines->index(newline) >= 0)
      newline -= 1
    endwhile
  elseif newline > b:oldline
    while (b:yat_section_header_lines->index(newline) >= 0)
      newline += 1
    endwhile
  endif

  newline = max([b:yat_firstline, min([b:yat_lastline, newline])])
  b:oldline = newline
  cursor(newline, fixed_column)
enddef

autocmd yat CursorMoved <buffer> SetCursor()
