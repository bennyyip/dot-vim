vim9script

g:sneak#label = 1
g:sneak#s_next = 1

hi! link Sneak QuickFixLine
hi! link SneakLabel QuickFixLine
hi! link SneakCurrent CurSearch

# [count]s enters |sneak-vertical-scope| mode.
# count should be LARGER than 1

# map S <Plug>Sneak_S
# map s <Plug>Sneak_s
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t

