vim9script
# Plugin: 'luochen1990/rainbow'

g:rainbow_active = 1

g:rainbow_conf = {
      \ 'guifgs': ['#458588', '#d79921', '#d3869b', '#fb4934'],
      \ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
      \ 'separately': {
      \    'ocaml': {
      \       'parentheses': ['start=/(\*\@!/ end=/)/ fold'],
      \    }
      \ }
      \}

# Some colorscheme invoke `syntax reset`, clears `syntax` autocmd
augroup vimrc
  auto syntax * call rainbow_main#load()
  auto colorscheme * call rainbow_main#load()
  auto BufEnter * call rainbow_main#load()
augroup END

