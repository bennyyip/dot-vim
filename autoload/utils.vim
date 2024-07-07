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

export def OpenInTab(fname: string) # [[[1
# Open file in new tab if it's not open in any tab
# Otherwise switch to the tab

    const b = bufnr(fname)
    if b == -1
      # Open in new tab if not exists
        execute 'tabedit ' .. fnameescape(fname)
        return
    endif

    for t in range(tabpagenr("$"))
      const bufs = tabpagebuflist(t + 1)
      for i in bufs
        if i == b
          # Switch to the tab
          execute "tabn " .. (t + 1)
          for w in range(winnr('$'))
            const wb = winbufnr(w + 1)
            if wb == b
              # Move cursor to the window
              execute $":{w + 1}wincmd w"
              return
            endif
          endfor
          return
        endif
      endfor
    endfor
enddef

export def SetTabWidth(n: number, expandtab: bool, softtabstop: number = -1) # [[[1
  execute $'setlocal shiftwidth={n} tabstop={n} softtabstop={softtabstop}'
  if expandtab
    setlocal expandtab
  else
    setlocal noexpandtab
  endif
enddef


# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
