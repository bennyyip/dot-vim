vim9script
# Plugin: 'luochen1990/rainbow'

g:rainbow_active = 1

# let gruvbox8 do it
if get(g:, "colors_name", "") != 'gruvbox8'
  g:rainbow_conf = {
    'guifgs': [ '#fb5944', '#b16286', '#458588', '#cc241d' ],
    'ctermfgs': [ '166', 'red', 'magenta', 'blue' ],
    'separately': {
      'ocaml': {
        'parentheses': ['start=/(\*\@!/ end=/)/ fold'],
      },
      'html': 0
    }
  }
endif

# Some colorscheme invoke `syntax reset`, clears `syntax` autocmd
augroup vimrc
  auto syntax * call rainbow_main#load()
  auto colorscheme * call rainbow_main#load()
  auto BufEnter * call rainbow_main#load()
augroup END


