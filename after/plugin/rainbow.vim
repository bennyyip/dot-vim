" Plugin: 'luochen1990/rainbow'
if !plugpac#has_plugin('rainbow')
  finish
endif

" Some colorscheme invoke `syntax reset`, clears `syntax` autocmd
augroup rainbow_config
  auto!
  auto syntax * call rainbow_main#load()
  auto colorscheme * call rainbow_main#load()
augroup END
