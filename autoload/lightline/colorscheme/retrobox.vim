vim9script

# ------------------------------------------------------------------------------------------------------------
# File: retrobox.vim
# Description: Retro groove color scheme similar to gruvbox originally designed by morhetz <morhetz@gmail.com>
# Author: Prateek Tade <prateek.tade@gmail.com>, ported from gruvbox8 of Lifepillar <lifepillar@lifepillar.me>
# Source: http//github.com/itchyny/lightline.vim
# Last Modified: 18 Dec 2022
# ------------------------------------------------------------------------------------------------------------

# if lightline#colorscheme#background() ==# 'dark'
  var  bg0 =    ['#1c1c1c', 234]
  var  bg1 =    ['#3c3836', 237]
  var  bg2 =    ['#504945', 239]
  var  bg4 =    ['#7c6f64', 243]
  var  fg1 =    ['#ebdbb2', 187]
  var  fg4 =    ['#a89984', 137]
  var  red =    ['#fb4934', 203]
  var  yellow = ['#fabd2f', 214]
  var  blue =   ['#82a598', 109]
  var  aqua =   ['#8ec07c', 107]
  var  orange = ['#fe8019', 208]
  var  green =  ['#b8bb26', 142]
# else
#   var bg0 =    ['#fbf1c7', 230]
#   var bg1 =    ['#ebdbb2', 187]
#   var bg2 =    ['#e5d4b1', 188]
#   var bg4 =    ['#a89984', 137]
#   var fg1 =    ['#3c3836', 237]
#   var fg4 =    ['#7c6f64', 243]
#   var red =    ['#9d0006', 124]
#   var yellow = ['#b57614', 172]
#   var blue =   ['#076678',  23]
#   var aqua =   ['#427b58',  29]
#   var orange = ['#ff5f00', 202]
#   var green =  ['#79740e',  64]
# endif

var p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

p.normal.left = [ [ bg0, fg1, 'bold' ], [ fg4, bg2 ] ]
p.normal.right = [ [ bg0, fg1], [ fg4, bg2 ] ]
p.normal.middle = [ [ fg4, bg1 ] ]
p.normal.error = [ [ bg0, orange ] ]
p.normal.warning = [ [ bg2, yellow ] ]

p.inactive.right = [ [ bg4, bg1 ], [ bg4, bg1 ] ]
p.inactive.left =  [ [ bg4, bg1 ], [ bg4, bg1 ] ]
p.inactive.middle = [ [ bg4, bg1 ] ]

p.insert.left = [ [ bg0, blue, 'bold' ], [ fg1, bg2 ] ]
p.insert.right = [ [ bg0, blue ], [ fg1, bg2 ] ]
p.insert.middle = [ [ fg4, bg2 ] ]

p.replace.left = [ [ bg0, red, 'bold' ], [ fg1, bg2 ] ]
p.replace.right = [ [ bg0, red ], [ fg1, bg2 ] ]
p.replace.middle = [ [ fg4, bg2 ] ]

p.visual.left = [ [ bg0, yellow, 'bold' ], [ bg0, bg4 ] ]
p.visual.right = [ [ bg0, yellow ], [ bg0, bg4 ] ]
p.visual.middle = [ [ fg4, bg1 ] ]

p.tabline.left = [ [ fg4, bg2 ] ]
p.tabline.tabsel = [ [ bg0, fg4, 'bold' ] ]
p.tabline.middle = [ [ bg0, bg0 ] ]
p.tabline.right = [ [ bg0, orange ] ]

g:lightline#colorscheme#retrobox#palette = lightline#colorscheme#flatten(p)
