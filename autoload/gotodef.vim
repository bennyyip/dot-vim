vim9script

export def GotoDefComplete(kind: string, L: string): string
  const cmd = L->split(' ')[0]
  const is_bang = cmd[-1 : ] == '!'
  var l = execute(kind)->split("\n")
  l->map((_, x) => {
    const m = x->matchlist('\v^(\a)?\s+(\S+)')
    return m->len() > 2 ? m[2] : ""
  })->filter('v:val != ""')
  if is_bang
    l->filter("v:val =~  '<Plug>'")
  endif
  return  l->join("\n")
enddef

export def DoGotoDef(kind: string, item: string)
  if kind == 'command' && item[0] !~# '\u'
    execute $"help {item}"
    return
  endif

  var cmdstr = $'verbose {kind} {item}'
  var lines = execute(cmdstr)->split("\n")
  for line in lines
    const m = line->matchlist('\v\s*Last set from (.+) line (\d+)')
    if !m->empty() && m[1] != null_string && m[2] != null_string
      exe $"e +{str2nr(m[2])} {m[1]}"
      return
    endif
  endfor
  echo 'no match!'
enddef

export const MapComplete = (_, L: string, _) => GotoDefComplete("map", L)
export const NmapComplete = (_, L: string, _) => GotoDefComplete("imap", L)
export const ImapComplete = (_, L: string, _) => GotoDefComplete("nmap", L)
export const CmapComplete = (_, L: string, _) => GotoDefComplete("cmap", L)
export const XmapComplete = (_, L: string, _) => GotoDefComplete("xmap", L)
