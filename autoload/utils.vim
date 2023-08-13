vim9script

export def Matchfuzzy(l: list<string>, str: string): list<string> # [[[1
  if str == ''
    return l
  else
    return matchfuzzy(l, str)
  endif
enddef

export def GetCurorLines() # [[[1
  const in_visual_mode = (mode() ==? 'v')
  const lnums = in_visual_mode
        \ ? range(line('''<'), line('''>'))
        \ : [line('.')]
enddef

export def GetVisualSelection(): string # [[[1
  const [lnum1, col1] = getpos("'<")[1 : 2]
  const [lnum2, col2] = getpos("'>")[1 : 2]
  var lines = getline(lnum1, lnum2)
  lines[-1] = lines[-1][ : col2 - (&selection == 'inclusive' ? 1 : 2)]
  lines[0] = lines[0][col1 - 1 : ]
  return join(lines, "\n")
enddef

export def Debounce(Fn: func, timeout: number = 200): func # [[[1
  var timer = -1
  return (...args: list<any>) => {
    if timer != -1
      timer_stop(timer)
    endif
    timer = timer_start(timeout, (t) => {
      timer = -1
      # TODO args
      # Fn(...args)
      Fn()
    })
  }
enddef

# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
