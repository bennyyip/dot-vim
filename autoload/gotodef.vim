vim9script
import autoload "utils.vim"


export def GotoDefComplete(kind: string, A: string, L: string, P: number): list<string>
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
  return  l->utils.Matchfuzzy(A)
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

export const MapComplete = (A: string, L: string, P: number) => GotoDefComplete("map", A, L, P)
export const NmapComplete = (A: string, L: string, P: number) => GotoDefComplete("imap", A, L, P)
export const ImapComplete = (A: string, L: string, P: number) => GotoDefComplete("nmap", A, L, P)
export const CmapComplete = (A: string, L: string, P: number) => GotoDefComplete("cmap", A, L, P)
export const XmapComplete = (A: string, L: string, P: number) => GotoDefComplete("xmap", A, L, P)
