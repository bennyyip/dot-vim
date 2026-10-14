vim9script
# https://dustri.org/b/a-simple-git-gutter-in-vim.html

if exists('g:loaded_gitsigns')
  finish
endif
g:loaded_gitsigns = 1

const group = 'gitsigns'
sign define GitSignsAdded   text=+ texthl=Added
sign define GitSignsChanged text=~ texthl=Changed
sign define GitSignsRemoved text=- texthl=Removed

def Clear(): void
  sign_unplace(group, {buffer: bufnr('%')})
  if exists('b:gitsigns_scl')
    &l:signcolumn = b:gitsigns_scl
    unlet b:gitsigns_scl
  endif
enddef

def Refresh(): void
  const buf = bufnr('%')
  Clear()
  const out = systemlist(printf('git -C %s --no-pager diff --unified=0 --no-color -- %s',
        shellescape(expand('%:p:h')), shellescape(expand('%:p'))))
  if v:shell_error != 0
    return
  endif
  # In a repo: reserve the column locally so signs don't shift text.
  b:gitsigns_scl = &l:signcolumn
  &l:signcolumn = 'yes'
  var list = []
  for line in out
    # Header: @@ -old_start,old_count +new_start,new_count @@ …
    if line[0] != '@'
      continue
    endif
    const m = matchlist(line, '^@@ -\d\+,\?\(\d*\) +\(\d\+\),\?\(\d*\)')
    if empty(m)
      continue
    endif
    const start = str2nr(m[2])
    var new = m[3] == '' ? 1 : str2nr(m[3])
    var name: string
    if new == 0
      new = 1
      const adjusted_start = max([1, start])
      name = 'GitSignsRemoved'
      for i in range(new)
        add(list, {buffer: buf, group: group, name: name, lnum: adjusted_start + i})
      endfor
    else
      name = m[1] == '0' ? 'GitSignsAdded' : 'GitSignsChanged'
      for i in range(new)
        add(list, {buffer: buf, group: group, name: name, lnum: start + i})
      endfor
    endif
  endfor
  if !empty(list)
    sign_placelist(list)
  endif
enddef

def Toggle(): void
  if get(b:, 'gitsigns_enabled', 1)
    b:gitsigns_enabled = 0
    Clear()
  else
    b:gitsigns_enabled = 1
    Refresh()
  endif
enddef

command! GitSignsToggle call Toggle()

augroup gitsigns
  autocmd!
  autocmd BufReadPost,BufWritePost * if get(b:, 'gitsigns_enabled', 1) | call Refresh() | endif
augroup END

# Jump to the next (dir>0) or previous (dir<0) changed chunk, wrapping around.
def Jump(dir: number): void
  # First line of each contiguous run of signed lines.
  var starts = []
  var prev = -2
  const signs = sign_getplaced(bufnr('%'), {group: group})[0].signs
  for lnum in sort(mapnew(signs, (_, s) => s.lnum), 'n')
    if lnum > prev + 1
      add(starts, lnum)
    endif
    prev = lnum
  endfor
  if empty(starts)
    return
  endif

  const cur = line('.')
  var target: number
  if dir > 0
    const wrap = starts[0]
    const ahead = filter(starts, (_, n) => n > cur)
    target = empty(ahead) ? wrap : ahead[0]
  else
    const wrap = starts[-1]
    const behind = filter(starts, (_, n) => n < cur)
    target = empty(behind) ? wrap : behind[-1]
  endif
  execute $'normal! {target}G'
enddef

command! GitSignsNext call Jump(1)
command! GitSignsPrev call Jump(-1)

if empty(maparg(']c', 'n'))
  nnoremap <silent> ]c <scriptcmd>Jump(1)<CR>
endif
if empty(maparg('[c', 'n'))
  nnoremap <silent> [c <scriptcmd>Jump(-1)<CR>
endif
