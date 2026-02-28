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
  [['==', '!='], { 'cond': (group, tick) => &ft != 'lua' }],
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
  [['yellow', 'red', 'green', 'blue']],
]

g:cycle_default_groups_for_lua = [
  [['==', '~=']],
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

