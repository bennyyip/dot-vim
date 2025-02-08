vim9script

def FoldText(): string
  var fcount: number = (v:foldend - v:foldstart + 1)
  var lenfcount: number = len(line('$'))
  var lpad: number = (&number ? &numberwidth : 0) + &foldcolumn + lenfcount
  const max: number = min([78, winwidth(0) - lenfcount - 1 - lpad])
  var line: string = getline(v:foldstart)->substitute('\t', repeat(" ", &ts), "g")
  if len(line) > max
    line = line[ : max - 2] .. "…"
  else
    line = line .. repeat(" ", max - len(line))
  endif
  return $"{line} ({fcount})"
enddef
set foldtext=FoldText()
