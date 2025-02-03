vim9script
# disable animation
g:operator#sandwich#set('all', 'all', 'highlight', 0)

g:sandwich#recipes = g:sandwich#default_recipes->extendnew([
  {'buns': ['“', '”'], 'input': ['Q']},
])

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

def MarkdownSetup()
  b:sandwich_recipes = g:sandwich#recipes->extendnew([
    {'buns': ['```', '```'], 'motionwise': ['line'], 'input': ['c'] },
    {'buns': ['**', '**'], 'input': ['b']},
    {'buns': ['$', '$'], 'input': ['$']},
    {'buns': ['_', '_'], 'input': ['i']},
    {'buns': ['~~', '~~'], 'input': ['~~']},

    {'buns': ['<span style="background-color:#ffc2c2">', '</span>'], 'input': ['R']},
    {'buns': ['<span style="background-color:#bfe0af">', '</span>'], 'input': ['G']},
    {'buns': ['<span style="background-color:#abdcf5">', '</span>'], 'input': ['B']},
    {'buns': ['<span style="background-color:#ffee99">', '</span>'], 'input': ['Y']},
  ])
  xmap <buffer> \r SR
  xmap <buffer> \g SG
  xmap <buffer> \b SB
  xmap <buffer> \y SY
enddef

augroup vimrc
  autocmd FileType markdown call MarkdownSetup()
augroup END
