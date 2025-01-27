vim9script
# disable animation
g:operator#sandwich#set('all', 'all', 'highlight', 0)

# g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
# g:sandwich#recipes += [
#   # {'buns': ['|', '|'], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0},
# ]

omap ik <Plug>(textobj-sandwich-auto-i)
xmap ik <Plug>(textobj-sandwich-auto-i)
omap ak <Plug>(textobj-sandwich-auto-a)
xmap ak <Plug>(textobj-sandwich-auto-a)

nmap ys <Plug>(sandwich-add)
onoremap <SID>line :normal! ^vg_<CR>
nmap <silent> yss <Plug>(sandwich-add)<SID>line
nmap ds <Plug>(sandwich-delete)
nmap dss <Plug>(sandwich-delete-auto)
nmap cs <Plug>(sandwich-replace)
nmap css <Plug>(sandwich-replace-auto)
xmap S <Plug>(sandwich-add)
