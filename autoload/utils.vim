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
  defer winrestview(save_view)
  # Trim spaces
  keepj silent! keeppatterns :%s#\s\+$##e
  # Remove trailing blank lines
  keepj silent! keeppatterns :%s#\($\n\s*\)\+\%$##e
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
    return globpath($'{$VIMSTATE}/session/', "*", 0, 1)->mapnew((_, v) => fnamemodify(v, ":t"))->join("\n")
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
export def A(cmd: string) # Switch between .cc and .h [[[1
  const name = expand('%:r')
  const ext = tolower(expand('%:e'))
  const sources = ['c', 'cc', 'cpp', 'cxx', 'mli']
  const headers = ['h', 'hh', 'hpp', 'hxx', 'ml']
  for pair in [[sources, headers], [headers, sources]]
    const [set1, set2] = pair
    if index(set1, ext) >= 0
      for h in set2
        const aname = $'{name}.{h}'
        for a in [aname, toupper(aname)]
          if filereadable(a)
            execute $"{cmd} {a}"
            return
          endif
        endfor
      endfor
    endif
  endfor
enddef

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
        execute $"imap <M-{x}> <Plug>(meta-{x})"
      endif
    endif
  endfor
enddef
export def KeepChangeMarksExec(cmd: string) # [[[1
  # do not clobber '[ '] on :write
  SaveChangeMarks()
  defer RestoreChangeMarks()
  execute(cmd)
enddef
var change_marks = [[0], [0]]
def SaveChangeMarks()
  change_marks = [getpos("'["), getpos("']")]
enddef
def RestoreChangeMarks()
  setpos("'[", change_marks[0])
  setpos("']", change_marks[1])
enddef

export def Syninfo(): string #[[[1
  const syn = Synnames()
  var info = ''
  if syn.visual != ''
    info ..= printf('visual: %s', syn.visual)
    if syn.visual != syn.visual_link
      info ..= printf(' (as %s)', syn.visual_link)
    endif
  endif
  if syn.effective != syn.visual
    if syn.visual != ''
      info ..= ', '
    endif
    info ..= printf('effective: %s', syn.effective)
    if syn.effective != syn.effective_link
      info ..= printf(' (as %s)', syn.effective_link)
    endif
  endif
  return info
enddef
def Synnames(): dict<any>
  var syn                 = {}
  const [lnum, cnum]        = [line('.'), col('.')]
  const [effective, visual] = [synID(lnum, cnum, 0), synID(lnum, cnum, 1)]
  syn.effective       = synIDattr(effective, 'name')
  syn.effective_link  = synIDattr(synIDtrans(effective), 'name')
  syn.visual          = synIDattr(visual, 'name')
  syn.visual_link     = synIDattr(synIDtrans(visual), 'name')
  return syn
enddef
#]]]
export def In_mkdMath(): bool # [[[1
  const in_mkdmath = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')->index('mkdMath') >= 0
  return in_mkdmath
enddef
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
