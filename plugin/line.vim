vim9script

const is_tty = !match(&term, 'linux')

def FilterAndJoin(l: list<string>, sep: string = " "): string
  return l->filter((_, v) => v != '')->join(sep)
enddef

def TabLabel(n: number): string
  const buflist = tabpagebuflist(n)
  const winnr = tabpagewinnr(n)

  var name = expand($'#{buflist[winnr - 1]}:t')
  name = name !=# '' ? name : '[No Name]'

  const modified = gettabwinvar(n, winnr, '&modified') ? '+' : gettabwinvar(n, winnr, '&modifiable') ? '' : '-'

  const hl = n == tabpagenr() ? '%#TabLineSel#' :  '%#TabLine#'

  # const sep = (n == tabpagenr() || n + 1 == tabpagenr() || n == tabpagenr('$')) ? '' : '|'
  const sep = ''

  var parts = [
    $"%{n}T", # mouse click
    $"{n}",
    name,
    modified,
  ]

  return  $"{hl}{parts->FilterAndJoin()} {sep}"
enddef

def g:Tabline(): string
  var s = ''

  for i in range(tabpagenr('$'))
    s ..= TabLabel(i + 1)
  endfor

  # after the last tab page fill with TabLineFill and reset tab page nr
  s ..= '%#TabLineFill#%T'

  # right-align the label to close the current tab page
  if tabpagenr('$') > 1
    s ..= '%=%#TabLineRight#%999X X '
  endif

  return s
enddef


def LineMode(): string
  const mode_map = {
    'n': 'N', 'i': 'I', 'R': 'R', 'v': 'V', 'V': 'L', "\<C-v>": 'B',
    'c': 'C', 's': 'S', 'S': 'L', "\<C-s>": 'B', 't': 'T'
  }
  const m = get(mode_map, mode(), '')
  var s = ''

  if ['B', 'V', 'L', 'S']->index(m) >= 0
    s = "Visual"
  elseif ['I', 'T']->index(m) >= 0
    s = "Insert"
  elseif ['R']->index(m) >= 0
    s = "Replace"
  else # ['C', 'N']->index(m) >= 0
    s = "Normal"
  endif

  return $"%#StatusLine{s}# {m} %#StatusLine#"
enddef

def LineFilename(): string
  const modified =  &modified ? '+' : &modifiable ? '' : '-'
  const readonly = &readonly ? (is_tty ? 'RO' : "\ue0a2") : ''

  if &filetype ==# 'qf'
    const wininfo = filter(getwininfo(), (i, v) => v.winnr == winnr())[0]
    if wininfo.loclist
      return "[Location List]"
    else
      return "[Quickfix List]"
    endif
  endif

  var fname = winwidth(0) < 70 ? expand('%:t') : expand('%:.')
  fname = fname->substitute('\\', '/', 'g')
  fname = '' !=# fname ? fname : '[No Name]'

  if &ft =~? 'dir\|fugitive\|undotree'
    return fname
  elseif &ft =~? 'yat'
    return 'YAT'
  else
    return [readonly, fname, modified]->FilterAndJoin()
  endif
enddef

def LineFugitive(): string
  if !exists('*g:FugitiveHead') || &ft == 'yat'
    return ''
  endif
  const mark = (is_tty ? '' : "\ue0a0")
  const branch = g:FugitiveHead()
  if branch == 'master' || branch == 'main'
    return mark
  endif
  return branch !=# '' ? $"{mark} {branch}" : ''
enddef

def LinePluginStatus(): string
  const jobs = get(g:, 'async_jobs', {})
  const njobs = jobs->len()

  var async_status = ''
  if njobs > 0
    async_status = 'Running'
    if njobs > 1
      async_status ..= $'({njobs})'
    endif
  endif

  # const tagname = exists('*taglist#Tlist_Get_Tagname_By_Line') ? taglist#Tlist_Get_Tagname_By_Line() : ''
  const tagname = get(b:, 'vista_nearest_method_or_function', '')
  return [tagname, async_status]->FilterAndJoin(' | ')
enddef

def Bold(s: string): string
  return $"%#StatusLineBold#{s}%#StatusLine#"
enddef

def LineFileInfo(): string
  if winwidth(0) < 70
    return ""
  endif

  const ffdict = {'dos': 'CRLF', 'mac': 'CR', 'unix': 'LF'}

  const fileencoding = toupper(&fenc !=# "" ? &fenc : &enc)
  const fileformat = ffdict->get(&ff, '')
  const filetype = &ft !=# "" ? &ft : "Fundamental"

  return [fileformat, fileencoding, filetype->Bold()]->FilterAndJoin('  ')
enddef

def g:StatusLine(): string
  const inactive = get(g:, 'statusline_winid', win_getid(winnr())) != win_getid(winnr())
  if inactive
    return [
      '%f', # filename
      '%=', # middle
      '%l,%c', # lineinfo
      '%P', # percent
    ]->FilterAndJoin()
  endif

  var parts = []

  var left = [
    [
      LineMode(), # mode
    ],
    [
      LineFilename()->Bold(), # filename
      &paste ? "PASTE" : "", # paste
    ],
  ]

  var mid = LinePluginStatus()

  var right = [
    [
      LineFugitive(), # fugitive
      LineFileInfo() # fileinfo
    ],
    [
      '%P', # percent
    ],
    [
      '%3l,%-3c', # lineinfo
    ],
  ]

  for [i, part] in left->items()
    if i == 0
      parts->add(part->FilterAndJoin(' | '))
      continue
    endif
    parts->add(part->FilterAndJoin(' | '))
  endfor

  const filetype = &ft !=# "" ? &ft : "Fundamental"

  parts->add($'%={mid}%=')

  var right_parts = []
  for [i, part] in right->items()
    right_parts->add(' ' .. part->FilterAndJoin('  ') .. ' ')
  endfor
  parts->extend(right_parts->reverse())

  return parts->FilterAndJoin()
enddef

hi default link StatusLineBold    StatusLine
hi default link StatusLineInsert  StatusLineBold
hi default link StatusLineNormal  StatusLineBold
hi default link StatusLineReplace StatusLineBold
hi default link StatusLineVisual  StatusLineBold
hi default link TabLineRight      TabLineSel

augroup vimrc
  autocmd VimEnter * {
    set tabline=%!g:Tabline()
    set statusline=%!g:StatusLine()
  }
augroup END
