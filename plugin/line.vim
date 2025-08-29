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

  const hl = n == tabpagenr() ? '%#BenTabLineSel#' :  '%#BenTabLine#'

  const sep = (n == tabpagenr() || n + 1 == tabpagenr() || n == tabpagenr('$')) ? '' : '|'

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
  s ..= '%#BenTabLineFill#%T'

  # right-align the label to close the current tab page
  if tabpagenr('$') > 1
    s ..= '%=%#BenTabLineRight#%999X X '
  endif

  return s
enddef


def LineMode(): string
  const mode_map = {
    'n': 'N', 'i': 'I', 'R': 'R', 'v': 'V', 'V': 'L', "\<C-v>": 'B',
    'c': 'C', 's': 'S', 'S': 'L', "\<C-s>": 'B', 't': 'T'
  }
  const m = get(mode_map, mode(), '')

  if ['B', 'V', 'L', 'S']->index(m) >= 0
    return $"%#BenStl_visual# {m}"
  elseif ['I', 'T']->index(m) >= 0
    return $"%#BenStl_insert# {m}"
  elseif ['R']->index(m) >= 0
    return $"%#BenStl_replace# {m}"
  else # ['C', 'N']->index(m) >= 0
    return $"%#BenStl_normal# {m}"
  endif
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
  else
    return [readonly, fname, modified]->FilterAndJoin()
  endif
enddef

def LineFugitive(): string
  if !plugpac#HasPlugin('vim-fugitive')
    return ''
  endif
  const mark = (is_tty ? '' : "\ue0a0")
  const branch = fugitive#Head()
  if branch == 'master' || branch == 'main'
    return mark
  endif
  return branch !=# '' ? $"{mark} {branch}" : ''
enddef

def LinePluginStatus(): string
  const jobs = get(g:, 'async_jobs', {})
  const async_status = jobs->len() > 0 ? 'Running' : ''

  # const coc_status = exists("*coc#status") ? coc#status() : ''
  # const coc_current_function = get(b:, 'coc_current_function', '')
  # return [coc_current_function, async_status, coc_status]
  const tagname = plugpac#HasPlugin('taglist') ? taglist#Tlist_Get_Tagname_By_Line() : ''
  return [tagname, async_status]->FilterAndJoin(' | ')
enddef

def LineFileInfo(): string
  if winwidth(0) < 70
    return ""
  endif

  const fileencoding = &fenc !=# "" ? &fenc : &enc
  const fileformat = &ff
  const filetype = &ft !=# "" ? &ft : "no ft"

  return [fileformat, fileencoding, filetype]->FilterAndJoin(' | ')
enddef

def g:StatusLine(): string
  const inactive = g:statusline_winid != win_getid(winnr())
  if inactive
    return [
      LineFilename(), # filename
      '%=', # middle
      '%p%%', # percent
      '%l:%c', # lineinfo
    ]->FilterAndJoin()
  endif

  var parts = []

  var left = [
    [
      LineMode(), # mode
      &paste ? "PASTE" : "", # paste
    ],
    [
      LineFugitive(), # fugitive
      LineFilename(), # filename
    ],
    [
      LinePluginStatus(), # plugin
    ]
  ]

  var right = [
    [
      '%3l:%-2c', # lineinfo
    ],
    [
      '%3p%%', # percent
    ],
    [
      LineFileInfo() # fileinfo
    ]
  ]

  for [i, part] in left->items()
    if i == 0
      parts->add($"{part->FilterAndJoin(' | ')}")
      continue
    endif
    parts->add($"%#BenStl_left{i}#{' ' .. part->FilterAndJoin(' | ')}")
  endfor
  parts->add('%#BenStl_middle#%=')

  var right_parts = []
  for [i, part] in right->items()
    right_parts->add($"%#BenStl_right{i}#{' ' .. part->FilterAndJoin(' | ') .. ' '}")
  endfor
  parts->extend(right_parts->reverse())

  return parts->FilterAndJoin()
enddef

def HiStyle(p: list<any>): string
  return get(p, 4, '') != '' ? $"term={p[4]} cterm={p[4]} gui={p[4]}" : ''
enddef

def Highlight()
  # const palette = g:lightline#colorscheme#gruvbox9#palette
  const palette = g:lightline#colorscheme#retrobox#palette

  for [key, group] in items({'tabsel': 'Sel', 'left': '', 'middle': 'Fill', 'right': 'Right'})
    var r = palette.tabline[key]->flattennew()
    exec $'hi BenTabLine{group} guifg={r[0]} guibg={r[1]} ctermfg={r[2]} ctermbg={r[3]} {HiStyle(r)}'
  endfor

  for part in ['left', 'right']
    var p = palette.normal[part]
    for [i, r] in p->items()
      exec $'hi BenStl_{part}{i} guifg={r[0]} guibg={r[1]} ctermfg={r[2]} ctermbg={r[3]} {HiStyle(r)}'
    endfor
    var r = palette.normal['middle'][0]
    exec $'hi BenStl_{part}{2} guifg={r[0]} guibg={r[1]} ctermfg={r[2]} ctermbg={r[3]} {HiStyle(r)}'
  endfor

  for m in ['normal', 'insert', 'visual', 'replace']
    var r = palette[m]['left'][0]
    exec $'hi BenStl_{m} guifg={r[0]} guibg={r[1]} ctermfg={r[2]} ctermbg={r[3]} {HiStyle(r)}'
  endfor


  var r = palette.normal['middle'][0]
  exec $'hi BenStl_middle guifg={r[0]} guibg={r[1]} ctermfg={r[2]} ctermbg={r[3]} {HiStyle(r)}'

enddef

set tabline=%!g:Tabline()
set statusline=%!g:StatusLine()

Highlight()
