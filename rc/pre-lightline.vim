vim9script

const is_tty = !match(&term, 'linux')
g:lightline = {
  'active': {
    'left':  [ [ 'mode', 'paste' ], [ 'fugitive', 'filename'], [ 'plugin' ] ],
    'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileinfo'] ]
  },
  'inactive': {
    'left': [ [ 'filename' ] ],
    'right': [ [ 'lineinfo' ], [ 'percent' ] ],
  },
  'component_function': {
    'fugitive':  'LightlineFugitive',
    'filename':  'LightlineFilename',
    'fileinfo':  'LightlineFileInfo',
    'plugin':    'LightlinePluginStatus',
  },
}

g:lightline.component = {
  'mode': '%{lightline#mode()[0]}',
}

g:lightline.colorscheme = 'gruvbox9'

def g:LightlineFilename(): string
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

def g:LightlineFugitive(): string
  const mark = (is_tty ? '' : "\ue0a0")
  const branch = fugitive#Head()
  if branch == 'master' || branch == 'main'
    return mark
  endif
  return branch !=# '' ? $"{mark} {branch}" : ''
enddef

def g:LightlinePluginStatus(): string
  const jobs = get(g:, 'async_jobs', {})
  const async_status = jobs->len() > 0 ? 'Running' : ''

  # const coc_status = exists("*coc#status") ? coc#status() : ''
  # const coc_current_function = get(b:, 'coc_current_function', '')
  # return [coc_current_function, async_status, coc_status]
  const tagname = taglist#Tlist_Get_Tagname_By_Line()
  return [tagname, async_status]->FilterAndJoin(' | ')
enddef

def g:LightlineFileInfo(): string
  if winwidth(0) < 70
    return ""
  endif

  const fileencoding = &fenc !=# "" ? &fenc : &enc
  const fileformat = &ff
  const filetype = &ft !=# "" ? &ft : "no ft"

  return [fileformat, fileencoding, filetype]->FilterAndJoin(' | ')
enddef

def FilterAndJoin(l: list<string>, sep: string = " "): string
  return l->filter("v:val != ''")->join(sep)
enddef

# let s:enable_nerd_font = !is_tty && !has('gui_running')
const enable_nerd_font = v:false
if enable_nerd_font
  g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
  g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
  g:lightline.tabline_separator = { 'left': "\ue0b8", 'right': "\ue0be" }
  g:lightline.tabline_subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
endif

# ]]]
# vim:fdm=marker:fmr=[[[,]]]:ft=vim
