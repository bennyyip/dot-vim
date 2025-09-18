vim9script
# Plugin: bootleq/vim-cycle


g:cycle_no_mappings = 1
g:cycle_default_groups = [
  [['absent', 'present']],
  [['true', 'false']],
  [['yes', 'no']],
  [['and', 'or']],
  [['on', 'off']],
  [['>', '<']],
  [['==', '!=']],
  [['是', '否']],
  [['有', '无']],
  [['在', '再']],
  [["in", "out"]],
  [["min", "max"]],
  [["get", "post"]],
  [["to", "from"]],
  [["read", "write"]],
  [['with', 'without']],
  [["exclude", "include"]],
  [["asc", "desc"]],
  [["next", "prev"]],
  [["encode", "decode"]],
  [["left", "right"]],
  [["hide", "show"]],
  [['(:)', '（:）', '「:」', '『:』'], 'sub_pairs'],
  [['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday'], 'hard_case', {'name': 'Days'}],
  [["enable", "disable"]],
  [["add", "remove"]],
  [['up', 'down']],
  [['after', 'before']],
]

g:cycle_default_groups_for_markdown = [
  [['^\(\s*\)- \[ \] ', '^\(\s*\)- \[x\] '],
    {regex: ['\1- [x] ', '\1- [ ] '],
      name: 'Markdown task checkbox'}],
]

nnoremap <Plug>CycleFallbackNext <C-A>
nnoremap <Plug>CycleFallbackPrev <C-X>

nmap <silent> <C-A> <Plug>CycleNext
vmap <silent> <C-A> <Plug>CycleNext
nmap <silent> <C-X> <Plug>CyclePrev
vmap <silent> <C-X> <Plug>CyclePrev

nmap <silent> <leader><C-A> <Plug>CycleSelect
vmap <silent> <leader><C-A> <Plug>CycleSelect

# nnoremap <expr> <silent> <C-X> <SID>TryCycle('x')
# vnoremap <expr> <silent> <C-X> <SID>TryCycle('x')
# nnoremap <expr> <silent> <C-A> <SID>TryCycle('p')
# vnoremap <expr> <silent> <C-A> <SID>TryCycle('p')
# def GetPatternAtCursor(pat: string): string
#   const col = col('.') - 1
#   const line = getline('.')
#   var ebeg = -1
#   var elen = -1
#   var cont = match(line, pat, 0)
#   while (ebeg >= 0 || (0 <= cont) && (cont <= col))
#     const contn = matchend(line, pat, cont)
#     if (cont <= col) && (col < contn)
#       ebeg = match(line, pat, cont)
#       elen = contn - ebeg
#       break
#     else
#       cont = match(line, pat, contn)
#     endif
#   endwhile
#   if ebeg >= 0
#     return strpart(line, ebeg, elen)
#   else
#     return ""
#   endif
# enddef

# def TryCycle(dir: string): string
#   const pat = GetPatternAtCursor('[+-]\?\d\+')
#   if pat != ""
#     if dir ==? 'x'
#       return "\<C-X>"
#     else
#       return "\<C-A>"
#     endif
#   else
#     const mode = mode() =~ 'n' ? 'w' : 'v'
#     const d = dir ==? 'x' ? -1 : 1
#     return ":\<C-U>call Cycle('" .. mode .. "', " .. d .. ", v:count1)\<CR>"
#   endif
# enddef
