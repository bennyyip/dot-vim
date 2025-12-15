vim9script

g:rainbow_active = 1

if get(g:, "colors_name", "") != 'gruvbox8'
  g:rainbow_conf = {
    'guifgs': [ '#fb5944', '#b16286', '#458588', '#cc241d' ],
    'ctermfgs': [ '166', 'red', 'magenta', 'blue' ],
    'separately': {
      'ocaml': {
        'parentheses': ['start=/(\*\@!/ end=/)/ fold'],
      },
      'pascal': 0,
      'html': 0
    }
  }
endif
