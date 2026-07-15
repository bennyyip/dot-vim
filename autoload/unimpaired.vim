vim9script

export def EditFileByOffset(num: number, first_or_last: number = 0)
  var file = expand('%:p')

  const sep = has('win32') && !&shellslash ? '\' : '/'

  if empty(file)
    file = getcwd() .. sep
  endif

  const path = fnamemodify(file, ':h')

  const filter_suffixes = substitute(escape(&suffixes, '~.*$^'), ',', '$\\|', 'g') .. '$'

  const files = path
    ->readdirex((x) => x.type == 'file' && x.name !~# filter_suffixes)
    ->map((k, v) => fnamemodify($'{path}{sep}{v.name}', ':p'))
    ->filter((k, v) => v != '')

  var idx = index(files, file)
  const l = files->len()
  idx = (idx + num) % l
  if idx < 0
    idx += l
  endif

  if first_or_last == -1
    idx = 0
  elseif first_or_last == 1
    idx = l - 1
  endif

  const f = fnameescape(fnamemodify(files[idx], ':.'))
  echo $'[{idx + 1}/{l}] {f}'
  silent execute $'edit {f}'
enddef

export def ToggleNumberOptions()
    const opt = &number && &relativenumber ? 'nonumber norelativenumber' : 'number relativenumber'
    execute $"set {opt}"
enddef

export def ToggleSpellOptions()
  const opt = &spell ? 'nospell' : 'spell'
  execute $"setlocal {opt}"
  echo opt
enddef

def DoBlankUp(...args: list<any>)
  :put!=repeat("\n", v:count1)
  :']+
enddef

def DoBlankDown(...args: list<any>)
  :put =repeat("\n", v:count1)
  :'[-
enddef

export def BlankUp(): string
  &opfunc = (mode) => DoBlankUp(mode)
  return 'g@l'
enddef

export def BlankDown(): string
  &opfunc = (mode) => DoBlankDown(mode)
  return 'g@l'
enddef

def DoMoveUp(...args: list<any>)
  execute $"move --{v:count1}"
enddef

def DoMoveSelectionUp(...args: list<any>)
  execute $"'<,'> move '<--{v:count1}"
enddef

def DoMoveDown(...args: list<any>)
  execute $"move +{v:count1}"
enddef

def DoMoveSelectionDown(...args: list<any>)
  execute $"'<,'> move '>+{v:count1}"
enddef

export def MoveUp(): string
  &opfunc = (mode) => DoMoveUp(mode)
  return 'g@l'
enddef

export def MoveDown(): string
  &opfunc = (mode) => DoMoveDown(mode)
  return 'g@l'
enddef

export def MoveSelectionUp(): string
  &opfunc = (mode) => DoMoveSelectionUp(mode)
  return 'g@'
enddef

export def MoveSelectionDown(): string
  &opfunc = (mode) => DoMoveSelectionDown(mode)
  return 'g@'
enddef

# function! s:ExecMove(cmd) abort
#   let old_fdm = &foldmethod
#   if old_fdm !=# 'manual'
#     let &foldmethod = 'manual'
#   endif
#   normal! m`
#   silent! exe a:cmd
#   norm! ``
#   if old_fdm !=# 'manual'
#     let &foldmethod = old_fdm
#   endif
# endfunction

# Move to a line based on indentation relative to the current indent.
# 'direction' can be -1 or 1 and indicates whether to move backward or
# forward. 'mode' can be -1, 0, 1, and indicates whether the relative indent
# should be less than, the same, or greater than the current indent. 'skip'
# specifies whether empty lines should be skipped.
export def MoveRelativeToIndent(direction: number, mode: number, skip: bool): void
  var line = line('.')
  var indent = indent(line)
  var last = line('$')
  var dir = min([max([direction, -1]), 1])

  while true
    line += dir
    if &wrapscan
      if line <= 0
        line = last
      elseif line >= last + 1
        line = 1
      endif
    endif
    if line == line('.')
      break
    endif
    if line < 1 || line > last
      break
    endif
    var indent2 = indent(line)
    if skip && virtcol([line, '$']) - 1 - indent2 <= 0
      continue
    endif
    var diff_sign = min([max([indent2 - indent, -1]), 1])
    var match = (mode == -1 && diff_sign == mode)
          || (mode == 1 && diff_sign == mode)
          || (mode == 0 && diff_sign == mode)
    if match
      execute $'normal! {line}gg^'
      break
    endif
  endwhile
enddef

# Go to git conflict or diff/patch hunk.
export def GotoConflictOrDiff(reverse: bool): void
  var flags = 'W'
  if reverse
    flags ..= 'b'
  endif
  search('^\(@@ .* @@\|[<=>]\{7\}\)', flags)
enddef

export def GotoComment(reverse: bool): void
  var flags = 'W'
  if reverse
    flags ..= 'b'
  endif
  var pattern = '\V' .. substitute(&commentstring, '%s', '\\.\\*', '')
  search(pattern, flags)
enddef

export def GotoLongLine(reverse: bool): void
  if &textwidth == 0
    return
  endif
  var flags = 'W'
  if reverse
    flags ..= 'b'
  endif
  var pattern = printf('^.\{%d\}', &textwidth + 1)
  search(pattern, flags)
enddef
