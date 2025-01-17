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

export def SetTabWidth(n: number, expandtab: bool, softtabstop: number = -1) # [[[1
  execute $'setlocal shiftwidth={n} tabstop={n} softtabstop={softtabstop}'
  if expandtab
    setlocal expandtab
  else
    setlocal noexpandtab
  endif
enddef

export def RemoveSpaces() # [[[1
  const save_view = winsaveview()
  # Trim spaces
  keepj silent! keeppatterns :%s#\s\+$##e
  # Remove trailing blank lines
  keepj silent! keeppatterns :%s#\($\n\s*\)\+\%$##e
  winrestview(save_view)
enddef

export def StrArray(line1: number, line2: number) # [[[1
  execute printf(":%s,%sQuote", line1, line2)
  execute printf(":%s,%sJoin ,", line1, line2)
  execute printf("normal kyss]")
enddef

export def Quote(quote: string, bang: string) # [[[1
  const q = quote == '' ? '"' : quote
  const l = getline('.')
  if l != '' || bang != '!'
    (q .. l .. q)->setline(line('.'))
  endif
enddef

export function Lilydjwg_join(sep, bang) range " [[[1
  if a:sep[0] == '\'
    let sep = strpart(a:sep, 1)
  else
    let sep = a:sep
  endif
  let lines = getline(a:firstline, a:lastline)
  if a:firstline == 1 && a:lastline == line('$')
    let dellast = 1
  else
    let dellast = 0
  endif
  exe a:firstline .. ',' .. a:lastline .. 'd_'
  if a:bang != '!'
    call map(lines, "substitute(v:val, '^\\s\\+\\|\\s\\+$', '', 'g')")
  endif
  call append(a:firstline-1, join(lines, sep))
  if dellast
    $d_
  endif
endfunction

export def SessionComplete(_, _, _): string # [[[1
    return globpath($'{$vimtmp}/session/', "*", 0, 1)->mapnew((_, v) => fnamemodify(v, ":t"))->join("\n")
enddef

export def FollowLink() # [[[1
  const filepath = expand('%')
  if !filereadable(filepath)
    return
  endif
  const resolved = resolve(filepath)
  if resolved ==# filepath
    return
  endif
  echom fnameescape(resolved)
  # FIXME: dont affect other window
  # enew
  # bwipeout #
  execute 'bwipeout %'
  execute 'edit ' .. fnameescape(resolved)
  redraw
enddef
# ]]]

const is_gvim = has('gui_running')
export def MapMeta() #[[[1
  for i in range(33, 122)
    const x = nr2char(i)
    for m in ["n", "c"]
      const cmd = mapcheck($"<Plug>(meta-{x})", m)
      if cmd != ""
        # echom $"{m} {x} {cmd}"
        execute is_gvim ? $"{m}map <M-{x}> <Plug>(meta-{x})"
          : $"{m}map <ESC>{x} <Plug>(meta-{x})"
      endif
    endfor
    if mapcheck($"<Plug>(meta-{x})", "i") != ""
      # map <ESC> slows entering normal mode. so only map for gui
      if is_gvim
        execute $"nmap <M-{x}> <Plug>(meta-{x})"
      endif
    endif
  endfor
enddef

# vim:fdm=marker:fmr=[[[,]]]:ft=vim
