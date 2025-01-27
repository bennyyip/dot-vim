vim9script

if !plugpac#HasPlugin('vim-sandwich') | finish | endif

b:sandwich_recipes = deepcopy(g:sandwich#default_recipes)
b:sandwich_recipes += [
  {'buns': ['```', '```'], 'motionwise': ['line'], 'input': ['c'] },
  {'buns': ['**', '**'], 'input': ['b']},
  {'buns': ['_', '_'], 'input': ['i']},
  {'buns': ['$', '$'], 'input': ['$']},
  {'buns': ['~~', '~~'], 'input': ['~~']},

  {'buns': ['<span style="background-color:#ffc2c2">', '</span>'], 'input': ['R']},
  {'buns': ['<span style="background-color:#bfe0af">', '</span>'], 'input': ['G']},
  {'buns': ['<span style="background-color:#abdcf5">', '</span>'], 'input': ['B']},
  {'buns': ['<span style="background-color:#ffee99">', '</span>'], 'input': ['Y']},
]

xmap \r SR
xmap \g SG
xmap \b SB
xmap \y SY
